# typed: true
# frozen_string_literal: true

module EML
  module UK
    module Models
      class Transaction < ::EML::Model
        extend T::Sig

        fields(%w[
          acceptor_code
          acceptor_location
          activity
          amount
          auth_id
          authorization_request_id
          currency
          eml_id
          expiration_minutes
          location
          merchant_category_code
          merchant_country
          notes
          original_transaction_date
          pos_transaction_time
          reason
          result
          retrieval_reference_number
          system_transaction_id
          timestamp
          transaction_amount
          transaction_currency
          user
        ])

        protected

        sig { params(field: String, raw_value: T.untyped).returns(T.untyped) }
        def field_value(field, raw_value)
          if field.match?(/date|time/)
            EML::UK::ParseDate.(raw_value)
          else
            raw_value
          end
        end
      end
    end
  end
end
