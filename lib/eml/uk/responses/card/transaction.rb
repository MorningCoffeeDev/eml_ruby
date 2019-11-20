# typed: strict
# frozen_string_literal: true

module EML
  module UK
    module Responses
      module Card
        class Transaction < ::EML::UK::Response
          extend T::Sig

          field :count

          sig { params(response: HTTP::Response, id: T.nilable(String)).void }
          def initialize(response, id: nil)
            super

            @transactions = T.let(
              nil,
              T.nilable(T::Array[::EML::UK::Models::Transaction])
            )
          end

          sig { returns(T::Array[::EML::UK::Models::Transaction]) }
          def transactions
            @transactions ||= body["transactions"].
              each_with_object([]) do |transaction, array|
                array << ::EML::UK::Models::Transaction.new(transaction)
              end
          end
        end
      end
    end
  end
end
