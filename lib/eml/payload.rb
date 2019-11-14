# typed: strict
# frozen_string_literal: true

# A payload is the data sent in the body of a request such as POST or PUT
module EML
  class Payload
    extend T::Sig

    sig { params(payload: T::Hash[Symbol, T.untyped]).void }
    def initialize(payload)
      assign_params(payload)
      validate_required_payload_presence
    end

    ENDPOINT_CLASS_TYPE = "Payload"

    class << self
      extend T::Sig

      sig do
        params(
          resource_class: T.untyped,
          endpoint: String,
          payload: T::Hash[Symbol, T.untyped]
        ).returns(T.untyped)
      end
      def convert(resource_class, endpoint, payload)
        endpoint_class = EML::EndpointClass.(
          class_type: ENDPOINT_CLASS_TYPE,
          resource_class: resource_class,
          endpoint: endpoint
        )

        convert_with_endpoint_class(
          endpoint: endpoint, endpoint_class: endpoint_class,
          payload: payload, resource_class: resource_class
        )
      end

      protected

      sig do
        params(
          endpoint_class: T.nilable(T.class_of(EML::Payload)),
          resource_class: T.untyped,
          endpoint: String,
          payload: T::Hash[Symbol, T.untyped]
        ).returns(T.untyped)
      end
      def convert_with_endpoint_class(
        endpoint_class:, resource_class:, endpoint:, payload:
      )
        return endpoint_class.new(payload) unless endpoint_class.nil?
        return payload if payload.empty?

        message = "No endpoint class can be found for resource, " \
          "#{resource_class}, with endpoint #{endpoint}"
        raise ArgumentError, message
      end
    end

    sig { returns(T::Hash[Symbol, T.untyped]) }
    def to_h
      instance_variables.each_with_object({}) do |variable_name, params|
        key = variable_name.to_s[1..-1].to_sym
        params[key] = instance_variable_get(variable_name)
        params[key] = params[key].to_h if params[key].respond_to?(:to_h)
      end
    end

    protected

    sig do
      params(param_name: Symbol, param_value: String, values: T::Array[String]).
        void
    end
    def validate_enum(param_name, param_value, values)
      return if values.include?(param_value)

      value_message = values.dup.
        tap { |vals| vals[-1] = "or #{vals.last}" }.
        join(", ")
      raise(ArgumentError, "#{param_name} must be one of #{value_message}")
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

    sig { params(params: T::Hash[Symbol, T.untyped]).void }
    def assign_params(params)
      params.each do |name, value|
        __send__(:"#{name}=", value)
      end
    end

    sig { void }
    def validate_required_payload_presence
      return unless self.class.const_defined?(:REQUIRED_VALUES)

      required_params = self.class.const_get(:REQUIRED_VALUES)
      required_params.each do |param_name|
        validate_required_payload_value_presence(param_name)
      end
    end

    # rubocop:disable Metrics/MethodLength
    sig { params(value_key: Symbol, object: EML::Payload).void }
    def validate_required_payload_value_presence(value_key, object: self)
      names = value_key.to_s.split(".")
      value = object.instance_variable_get(:"@#{names.shift}")

      if value.nil?
        raise(
          ArgumentError,
          "#{value_key} was not supplied but it is a required field"
        )
      end

      if names.length.positive?
        value_key = names.join(".").to_sym
        validate_required_payload_value_presence(value_key, object: value)
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
