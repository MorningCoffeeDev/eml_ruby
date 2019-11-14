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

          sig { params(is_account_expiry: String).returns(String) }
          def is_account_expiry=(is_account_expiry)
            validate_boolean("is_account_expiry", is_account_expiry)
            @Is_account_expiry = is_account_expiry
          end

          sig { params(is_fee_free: String).returns(String) }
          def is_fee_free=(is_fee_free)
            validate_boolean("is_fee_free", is_fee_free)
            @Is_fee_free = is_fee_free
          end

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
