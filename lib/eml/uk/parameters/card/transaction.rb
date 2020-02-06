# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Card
        class Transaction < ::EML::UK::Parameters
          REQUIRED_CONFIG = T.let(%i[program].freeze, T::Array[Symbol])
          OPTIONAL_CONFIG = T.let(%i[search_parameter].freeze, T::Array[Symbol])

          private

          FIELDS_OPTIONS = T.let(%i[
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
          ].freeze, T::Array[Symbol])

          sig { params(params: T::Hash[Symbol, T.untyped]).void }
          def initialize(params)
            super

            @fields = T.let(nil, T.nilable(String))
          end

          sig { params(fields: T::Array[Symbol]).returns(String) }
          def fields=(fields)
            unless fields.first == :all
              fields.each do |field|
                validate_array(:fields, field, FIELDS_OPTIONS)
              end
            end

            @fields = fields.join(",")
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :filter

          sig { returns(T.nilable(String)) }
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
