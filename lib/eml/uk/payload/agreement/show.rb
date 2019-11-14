# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Agreement
        class Show < ::EML::UK::Payload
          OPTIONAL_DEFAULTS = %i[merchant_group program].freeze

          private

          sig { params(bin: String).returns(String) }
          attr_accessor :bin

          sig { params(country: String).returns(String) }
          attr_accessor :country

          sig { params(developer: String).returns(String) }
          attr_accessor :developer

          # rubocop:disable Naming/VariableName
          sig { params(is_account_expiry: T::Boolean).returns(String) }
          def is_account_expiry=(is_account_expiry)
            @Is_account_expiry = is_account_expiry.inspect
          end

          sig { params(is_fee_free: T::Boolean).returns(String) }
          def is_fee_free=(is_fee_free)
            @Is_fee_free = is_fee_free.inspect
          end
          # rubocop:enable Naming/VariableName

          sig { params(merchant_group: String).returns(String) }
          attr_accessor :merchant_group

          sig { params(program: String).returns(String) }
          attr_accessor :program

          sig { params(region: String).returns(String) }
          attr_accessor :region
        end
      end
    end
  end
end
