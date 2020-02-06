# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Lock < ::EML::UK::Payload
          REQUIRED_CONFIG = T.let(%i[merchant_group].freeze, T::Array[Symbol])
          REQUIRED_VALUES = T.let(%i[note reason].freeze, T::Array[Symbol])

          sig { params(payload: T::Hash[Symbol, T.untyped]).void }
          def initialize(payload)
            super

            @reason = T.let(nil, T.nilable(Symbol))
          end

          private

          sig { returns(T.nilable(String)) }
          attr_accessor :merchant_group

          sig { returns(T.nilable(String)) }
          attr_accessor :note

          REASONS = T.let(%i[
            Damaged DataBreach Lost Miscellaneous OfficeError
            PastAccountExpirationDate Stolen UnclaimedProperty
          ].freeze, T::Array[Symbol])

          sig { params(reason: Symbol).void }
          def reason=(reason)
            validate_enum(:reason, reason, REASONS)
            @reason = reason
          end
        end
      end
    end
  end
end
