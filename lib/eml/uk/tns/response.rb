# typed: strict
# frozen_string_literal: true

module EML
  module UK
    module TNS
      class Response
        extend T::Sig

        sig { returns(T::Array[EML::UK::Models::TNS::Transaction]) }
        attr_reader :transactions

        sig { params(response: T::Hash[Symbol, T.untyped]).void }
        def initialize(response)
          @transactions = T.let(
            model_transactions(response),
            T::Array[EML::UK::Models::TNS::Transaction]
          )
        end

        private

        sig do
          params(response: T::Hash[Symbol, T.untyped]).
            returns(T::Array[EML::UK::Models::TNS::Transaction])
        end
        def model_transactions(response)
          response[:Transactions].
            each_with_object([]) do |raw_transaction, transactions|
              transactions << EML::UK::Models::TNS::Transaction.
                new(raw_transaction)
            end
        end
      end
    end
  end
end
