# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Card < APIResource
      ENDPOINT_BASE = T.let("cards", String)

      class << self
        extend T::Sig

        # Activate a card
        # Activation is a necessary first step but does not associate a person
        # with the card; that requires registration
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Activation
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Activation
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def activate(id:, payload:, params: {})
          new(id: id).
            request(:post, "activations", payload: payload, params: params)
        end

        # Register a card
        # Registration is associating a person with an activated card
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Register
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Register
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def register(id:, payload:, params: {})
          new(id: id).
            request(:post, "register", payload: payload, params: params)
        end

        # Retrieve card information
        #
        # @param id [String] Card identifier
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Info
        sig do
          params(id: String, params: T::Hash[Symbol, T.untyped]).
            returns(EML::Response)
        end
        def show(id:, params: {})
          new(id: id).request(:get, params: params)
        end

        # Access a card's transaction history
        # The level of detail in this transaction history is relatively
        # extensive and therefore would not be suitable for presentation to card
        # holders
        #
        # @param id [String] Card identifier
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Transactions
        sig do
          params(
            id: String,
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def transactions(id:, params: {})
          new(id: id).request(:get, "transactions", params: params)
        end

        # Reload a card
        # Add funds onto an active card, provided the amount does not violate
        # the existing regulations
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Reload
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Reload
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def reload(id:, payload:, params: {})
          new(id: id).
            request(:post, "reloads", payload: payload, params: params)
        end

        # Unload a card
        # Remove funds from a card
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Unload
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Unload
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def unload(id:, payload:, params: {})
          new(id: id).request(:post, "unload", payload: payload, params: params)
        end

        # Lock a card
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Lock
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Lock
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def lock(id:, payload:, params: {})
          new(id: id).request(:post, "locks", payload: payload, params: params)
        end

        # Unlock a card
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Unlock
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Unlock
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def unlock(id:, payload:, params: {})
          new(id: id).
            request(:post, "unlocks", payload: payload, params: params)
        end

        # Void a card
        #
        # @param id [String] Card identifier
        # @param payload [Hash] POST payload that conforms to
        #   EML::UK::Payload::Card::Void
        # @param params [Hash] URL query string parameters that conform to
        #   EML::UK::Parameters::Card::Void
        sig do
          params(
            id: String,
            payload: T::Hash[Symbol, T.untyped],
            params: T::Hash[Symbol, T.untyped]
          ).returns(EML::Response)
        end
        def void(id:, payload:, params: {})
          new(id: id).request(:post, "voids", payload: payload, params: params)
        end
      end
    end
  end
end
