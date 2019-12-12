# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Card
        class Transaction < ::EML::UK::Parameters
          REQUIRED_CONFIG = %i[program].freeze
          OPTIONAL_CONFIG = %i[search_parameter].freeze

          private

          FIELDS_OPTIONS = %i[
            activity
            amount
            authorization_request_id
            currency
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
            user
          ].freeze

          sig { params(fields: T::Array[Symbol]).returns(String) }
          def fields=(fields)
            unless fields.first == :all
              fields.each do |field|
                validate_array(:fields, field, FIELDS_OPTIONS)
              end
            end

            @fields = fields.join(",")
          end

          sig { params(filter: String).returns(String) }
          attr_accessor :filter

          sig { params(program: String).returns(String) }
          attr_accessor :program

          sig { params(search_parameter: String).returns(String) }
          def search_parameter=(search_parameter)
            validate_search_parameter(search_parameter)
            @search_parameter = search_parameter
          end
        end
      end
    end
  end
end
