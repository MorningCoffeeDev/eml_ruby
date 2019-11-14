# typed: strict
# frozen_string_literal: true

# A payload is the data sent in the body of a request such as POST or PUT
module EML
  module UK
    class Payload < ::EML::Payload
      extend T::Sig

      sig { params(payload: T::Hash[Symbol, T.untyped]).void }
      def initialize(payload)
        payload = merge_optional_config(payload)
        payload = merge_required_config(payload)
        super
      end

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
          endpoint_class = EML::UK::EndpointClass.(
            class_type: self::ENDPOINT_CLASS_TYPE,
            resource_class: resource_class,
            endpoint: endpoint
          )

          convert_with_endpoint_class(
            endpoint: endpoint, endpoint_class: endpoint_class,
            payload: payload, resource_class: resource_class
          )
        end
      end

      protected

      BOOLEAN_OPTIONS = %w[true false].freeze

      sig { params(param_name: String, param_value: String).void }
      def validate_boolean(param_name, param_value)
        return if BOOLEAN_OPTIONS.include?(param_value)

        message = "#{param_name} should be the string 'true' or 'false' but " \
          "received #{param_value.inspect}"
        raise ArgumentError, message
      end

      sig { params(dob: String).void }
      def validate_dob(dob)
        validate_max_length(:dob, dob, 8)
        dob_i = dob.to_i
        raise ArgumentError if dob_i < 1_011_900 || dob_i > 13_000_000
      rescue ArgumentError
        raise ArgumentError, "DOB should be in the format MMDDYYYY"
      end

      private

      sig do
        params(payload: T::Hash[Symbol, T.untyped]).
          returns(T::Hash[Symbol, T.untyped])
      end
      def merge_optional_config(payload)
        return payload unless self.class.const_defined?(:OPTIONAL_CONFIG)

        config = EML::UK.config
        self.class.const_get(:OPTIONAL_CONFIG).
          each_with_object(payload.dup) do |name, new_payload|
            new_payload[name] ||= config.public_send(name)
          end
      end

      sig do
        params(payload: T::Hash[Symbol, T.untyped]).
          returns(T::Hash[Symbol, T.untyped])
      end
      def merge_required_config(payload)
        return payload unless self.class.const_defined?(:REQUIRED_CONFIG)

        config = EML::UK.config
        self.class.const_get(:REQUIRED_CONFIG).
          each_with_object(payload.dup) do |name, new_payload|
            new_payload[name] ||= config.require_parameter(name)
          end
      end
    end
  end
end
