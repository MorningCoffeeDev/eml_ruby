# typed: strict
# frozen_string_literal: true

module EML
  module UK
    module TNS
      class Response
        extend T::Sig

        attr_reader :transactions

        sig { params(response: T::Hash[Symbol, T.untyped]).void }
        def initialize(response)
          @transactions = response[:Transactions].
            each_with_object([]) do |raw_transaction, transactions|
              transactions << EML::UK::Models::TNSTransaction.
                new(raw_transaction)
            end
        end
      end
    end
  end
end