# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Lock < ::EML::UK::Payload
          REQUIRED_CONFIG = %i[merchant_group].freeze
          REQUIRED_VALUES = %i[note reason].freeze

          private

          sig { params(merchant_group: String).returns(String) }
          attr_accessor :merchant_group

          sig { params(note: String).returns(String) }
          attr_accessor :note

          REASONS = %w[
            Damaged DataBreach Lost Miscellaneous OfficeError
            PastAccountExpirationDate Stolen UnclaimedProperty
          ].freeze

          sig { params(reason: String).void }
          def reason=(reason)
            validate_enum(:reason, reason, REASONS)
            @reason = reason
          end
        end
      end
    end
  end
end
