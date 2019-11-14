# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Reload < ::EML::UK::Payload
          REQUIRED_CONFIG = %i[merchant_group].freeze
          REQUIRED_VALUES = %i[amount location.country].freeze

          private

          sig { params(amount: Numeric).returns(Numeric) }
          attr_accessor :amount

          # While client_time is sent to EML as a JSON DateTime, there are many
          # classes that could be used which causes a typing challenge. For
          # example, if Rails is in use, we will probably receive a
          # ActiveSupport::TimeWithZone
          sig { params(client_time: T.untyped).returns(T.untyped) }
          attr_accessor :client_time

          sig { params(location: Hash).void }
          def location=(location)
            @location = EML::UK::Payload::Location.new(location)
          end

          sig { params(merchant_group: String).returns(String) }
          attr_accessor :merchant_group

          sig { params(note: String).returns(String) }
          attr_accessor :note
        end
      end
    end
  end
end
