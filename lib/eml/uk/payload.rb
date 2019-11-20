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
            class_type: const_get(:ENDPOINT_CLASS_TYPE),
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
