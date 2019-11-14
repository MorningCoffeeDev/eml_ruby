# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Model
      class Transaction
        FIELDS = %w[
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
        ].freeze
        private_constant :FIELDS

        FIELDS.each { |field| __send__(:attr_reader, :"#{field}") }

        def initialize(response)
          FIELDS.each do |field|
            value = field_value(field, response[field])
            instance_variable_set(:"@#{field}", value)
          end
        end

        private

        def field_value(field, raw_value)
          if field.include?("time")
            EML::UK::ParseDate.(raw_value)
          else
            raw_value
          end
        end
      end
    end
  end
end
