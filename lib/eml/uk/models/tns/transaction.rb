# typed: true
# frozen_string_literal: true

module EML
  module UK
    module Models
      module TNS
        class Transaction < ::EML::Model
          extend T::Sig

          fields(
            "AuthorizationRequestId" => :authorizationRequestId,
            "Card" => :card,
            "Cards" => :cards,
            "EmlId" => :emlId,
            "MerchantCategoryCode" => :merchantCategoryCode,
            "MerchantCountry" => :merchantCountry,
            "Note" => :note,
            "OriginalTransactionDate" => :originalDate,
            "PosTransactionTime" => :posTime,
            "Reason" => :reason,
            "Result" => :result,
            "RetrievalReferenceNumber" => :retrievalReferenceNumber,
            "TransactionAmount" => :amount,
            "TransactionCurrency" => :currency,
            "TransactionDescription" => :description,
            "TransactionId" => :transactionId,
            "TransactionLocation" => :location,
            "TransactionTime" => :time
          )

          sig { params(raw_values: T::Hash[String, T.untyped]).void }
          def initialize(raw_values)
            super
            initialize_cards
          end

          private

          sig { void }
          def initialize_cards
            @card = Card.new(@card) unless @card.nil?
            @cards = (@cards || []).each_with_object([]) do |card, cards|
              cards << Card.new(card)
            end
          end
        end
      end
    end
  end
end
