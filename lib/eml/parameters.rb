# typed: strict
# frozen_string_literal: true

# A payload is the data sent in the body of a request such as POST or PUT
module EML
  class Parameters
    extend T::Sig

    sig { params(params: T::Hash[Symbol, T.untyped]).void }
    def initialize(params)
      assign_params(params)
      validate_required_params_presence
    end

    ENDPOINT_CLASS_TYPE = "Parameters"

    class << self
      extend T::Sig

      sig do
        params(
          resource_class: T.untyped,
          endpoint: String,
          params: T::Hash[Symbol, T.untyped]
        ).returns(T.untyped)
      end
      def convert(resource_class, endpoint, params)
        endpoint_class = EML::EndpointClass.(
          class_type: ENDPOINT_CLASS_TYPE, resource_class: resource_class,
          endpoint: endpoint
        )

        convert_with_endpoint_class(
          endpoint: endpoint, endpoint_class: endpoint_class,
          resource_class: resource_class, params: params
        )
      end

      protected

      sig do
        params(
          endpoint_class: T.nilable(T.class_of(EML::Parameters)),
          resource_class: T.untyped,
          endpoint: String,
          params: T::Hash[Symbol, T.untyped]
        ).returns(T.untyped)
      end
      def convert_with_endpoint_class(
        endpoint_class:, resource_class:, endpoint:, params:
      )
        return endpoint_class.new(params) unless endpoint_class.nil?
        return params if params.empty?

        message = "No endpoint class can be found for resource, " \
          "#{resource_class}, with endpoint #{endpoint}"
        raise ArgumentError, message
      end
    end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    def to_h
      instance_variables.each_with_object({}) do |variable_name, params|
        key = T.must(variable_name.to_s[1..-1]).to_sym
        params[key] = instance_variable_get(variable_name)

        if !params[key].nil? && params[key].respond_to?(:to_h)
          params[key] = params[key].to_h
        end
      end
    end

    protected

    sig do
      params(
        param_name: Symbol,
        param_value: Symbol,
        allowed_values: T::Array[Symbol]
      ).void
    end
    def validate_array(param_name, param_value, allowed_values)
      return if allowed_values.include?(param_value)

      error_message = "#{param_name} can include any of " \
        "#{array_as_string(allowed_values)} but included #{param_value}"
      raise ArgumentError, error_message
    end

    sig do
      params(param_name: Symbol, param_value: String, length: Integer).void
    end
    def validate_max_length(param_name, param_value, length)
      return if param_value.to_s.length <= length

      raise(
        ArgumentError,
        "#{param_name} is expected to be no more than #{length} characters"
      )
    end

    private

    sig { params(array: T::Array[Symbol]).returns(String) }
    def array_as_string(array)
      array.dup.tap { |vals| vals[-1] = "or #{vals.last}" }.join(", ")
    end

    sig { params(params: T::Hash[Symbol, T.untyped]).void }
    def assign_params(params)
      params.each do |name, value|
        __send__(:"#{name}=", value)
      end
    end

    sig { void }
    def validate_required_params_presence
      return unless self.class.const_defined?(:REQUIRED_VALUES)

      required_params = self.class.const_get(:REQUIRED_VALUES)
      required_params.each do |param_name|
        validate_required_parameter_presence(param_name)
      end
    end

    # rubocop:disable Metrics/MethodLength
    sig { params(param_name: Symbol, object: EML::Parameters).void }
    def validate_required_parameter_presence(param_name, object: self)
      names = param_name.to_s.split(".")
      value = object.instance_variable_get(:"@#{names.shift}")

      if value.nil?
        raise(
          ArgumentError,
          "#{param_name} was not supplied but it is a required field"
        )
      end

      if names.length.positive?
        param_name = names.join(".").to_sym
        validate_required_parameter_presence(param_name, object: value)
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
