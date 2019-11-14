# typed: strict
# frozen_string_literal: true

module EML
  module UK
    module Responses
      module Card
        class Reload < ::EML::UK::Response
          extend T::Sig

          field :adjusted_balance
          field :available_balance
          field :currency
          field :system_transaction_id
        end
      end
    end
  end
end
