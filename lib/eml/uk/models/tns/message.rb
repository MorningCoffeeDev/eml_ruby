# typed: true
# frozen_string_literal: true

module EML
  module UK
    module Models
      module TNS
        class Message < ::EML::Model
          extend T::Sig

          fields("Transactions" => :transactions)

          sig { params(raw_values: T::Hash[Symbol, T.untyped]).void }
          def initialize(raw_values)
            @transactions = raw_values[:Transactions].
              each_with_object([]) do |raw_transaction, transactions|
                transactions << EML::UK::Models::TNS::Transaction.
                  new(raw_transaction)
              end
          end
        end
      end
    end
  end
end
