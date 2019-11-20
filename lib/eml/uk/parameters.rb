# typed: strict
# frozen_string_literal: true

# Parameters are the elements of a query string.
# For example: example.com?param1=value1&param2=value2
module EML
  module UK
    class Parameters < ::EML::Parameters
      extend T::Sig

      sig { params(params: T::Hash[Symbol, T.untyped]).void }
      def initialize(params)
        params = merge_required_config(params)
        params = merge_optional_config(params)
        super
      end

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
          endpoint_class = EML::UK::EndpointClass.(
            class_type: const_get(:ENDPOINT_CLASS_TYPE),
            resource_class: resource_class, endpoint: endpoint
          )

          convert_with_endpoint_class(
            endpoint: endpoint, endpoint_class: endpoint_class,
            resource_class: resource_class, params: params
          )
        end
      end

      protected

      SEARCH_PARAMETER_OPTIONS = T.let(
        %w[
          ActualCardNumber CarrierNumber ClientTrackingId ExternalId
          PaymentTrackingID PrintText
        ].freeze,
        T::Array[String]
      )

      sig { params(value: String).void }
      def validate_search_parameter(value)
        return if SEARCH_PARAMETER_OPTIONS.include?(value)

        message = "search_parameter should be one of " \
          "#{SEARCH_PARAMETER_OPTIONS.join(", ")} but received #{value.inspect}"
        raise ArgumentError, message
      end

      private

      sig do
        params(params: T::Hash[Symbol, T.untyped]).
          returns(T::Hash[Symbol, T.untyped])
      end
      def merge_optional_config(params)
        return params unless self.class.const_defined?(:OPTIONAL_CONFIG)

        config = EML::UK.config
        self.class.const_get(:OPTIONAL_CONFIG).
          each_with_object(params.dup) do |name, new_params|
            new_params[name] ||= config.public_send(name)
          end
      end

      sig do
        params(params: T::Hash[Symbol, T.untyped]).
          returns(T::Hash[Symbol, T.untyped])
      end
      def merge_required_config(params)
        return params unless self.class.const_defined?(:REQUIRED_CONFIG)

        config = EML::UK.config
        self.class.const_get(:REQUIRED_CONFIG).
          each_with_object(params.dup) do |name, new_params|
            new_params[name] ||= config.require_parameter(name)
          end
      end
    end
  end
end
