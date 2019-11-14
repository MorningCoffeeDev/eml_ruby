# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Activation < ::EML::UK::Payload
          REQUIRED_VALUES =
            %i[amount location.name location.country sales_channel].freeze
          REQUIRED_CONFIG = %i[merchant_group].freeze

          private

          sig { params(amount: Numeric).returns(Numeric) }
          attr_accessor :amount

          sig { params(campaign: String).returns(String) }
          attr_accessor :campaign

          sig { params(cardholder_user_id: String).returns(String) }
          attr_accessor :cardholder_user_id

          # While client_order_date is sent to EML as a JSON DateTime,
          # there are many classes that could be used which causes a typing
          # challenge. For example, if Rails is in use, we will probably receive
          # a ActiveSupport::TimeWithZone
          sig { params(client_order_date: T.untyped).returns(T.untyped) }
          attr_accessor :client_order_date

          sig { params(client_reference_number: String).void }
          def client_reference_number=(client_reference_number)
            validate_max_length(
              :client_reference_number, client_reference_number, 50
            )
            @client_reference_number = client_reference_number
          end

          # While client_time is sent to EML as a JSON DateTime,
          # there are many classes that could be used which causes a typing
          # challenge. For example, if Rails is in use, we will probably receive
          # a ActiveSupport::TimeWithZone
          sig { params(client_time: T.untyped).returns(T.untyped) }
          attr_accessor :client_time

          sig { params(client_tracking_id: String).void }
          def client_tracking_id=(client_tracking_id)
            validate_max_length(
              :client_tracking_id, client_tracking_id, 50
            )
            @client_tracking_id = client_tracking_id
          end

          sig { params(location: Hash).void }
          def location=(location)
            @location = EML::UK::Payload::Location.new(location)
          end

          sig { params(merchant_group: String).returns(String) }
          attr_accessor :merchant_group

          sig { params(note: String).returns(String) }
          attr_accessor :note

          SALES_CHANNELS = %w[Online InPerson].freeze

          sig { params(sales_channel: String).returns(String) }
          attr_accessor :sales_channel
        end
      end
    end
  end
end
