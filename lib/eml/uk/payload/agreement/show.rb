# typed: strict
# frozen_string_literal: true

# rubocop:disable Naming/VariableName
module EML
  module UK
    class Payload
      module Agreement
        class Show < ::EML::UK::Payload
          OPTIONAL_DEFAULTS =
            T.let(%i[merchant_group program].freeze, T::Array[Symbol])

          sig { params(payload: T::Hash[Symbol, T.untyped]).void }
          def initialize(payload)
            super

            @Is_account_expiry = T.let(nil, T.nilable(String))
            @Is_fee_free = T.let(nil, T.nilable(String))
          end

          private

          sig { returns(T.nilable(String)) }
          attr_accessor :bin

          sig { returns(T.nilable(String)) }
          attr_accessor :country

          sig { returns(T.nilable(String)) }
          attr_accessor :developer

          sig { params(is_account_expiry: T::Boolean).returns(String) }
          def is_account_expiry=(is_account_expiry)
            @Is_account_expiry = is_account_expiry.inspect
          end

          sig { params(is_fee_free: T::Boolean).returns(String) }
          def is_fee_free=(is_fee_free)
            @Is_fee_free = is_fee_free.inspect
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :merchant_group

          sig { returns(T.nilable(String)) }
          attr_accessor :program

          sig { returns(T.nilable(String)) }
          attr_accessor :region
        end
      end
    end
  end
end
# rubocop:enable Naming/VariableName
