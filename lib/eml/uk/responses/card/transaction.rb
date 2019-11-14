# typed: strict
# frozen_string_literal: true

module EML
  module UK
    module Responses
      module Card
        class Transaction < ::EML::UK::Response
          extend T::Sig

          field :count

          sig { returns(T::Array[::EML::UK::Model::Transaction]) }
          def transactions
            @transactions ||= body["transactions"].
              each_with_object([]) do |transaction, array|
                array << ::EML::UK::Model::Transaction.new(transaction)
              end
          end
        end
      end
    end
  end
end
