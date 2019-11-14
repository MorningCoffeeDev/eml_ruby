# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Agreement < APIResource
      ENDPOINT_BASE = T.let("agreements", String)

      class << self
        extend T::Sig

        # Cardholder Agreement Lookup
        # Look up the cardholder agreement URL for a card that has not been
        # created
        #
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Agreement::Show
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Agreement::Show
        sig do
          params(
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def show(payload: {}, params: {})
          new.request(:post, payload: payload, params: params)
        end
      end
    end
  end
end
