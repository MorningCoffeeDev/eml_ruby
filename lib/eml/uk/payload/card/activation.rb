# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Activation < ::EML::UK::Payload
          REQUIRED_VALUES = T.let(
            %i[amount location.name location.country sales_channel].freeze,
            T::Array[Symbol]
          )
          REQUIRED_CONFIG = T.let(%i[merchant_group].freeze, T::Array[Symbol])

          sig { params(payload: T::Hash[Symbol, T.untyped]).void }
          def initialize(payload)
            super

            @client_reference_number = T.let(nil, T.nilable(String))
            @client_tracking_id = T.let(nil, T.nilable(String))
            @location = T.let(nil, T.nilable(EML::UK::Payload::Location))
          end

          private

          sig { returns(T.nilable(Numeric)) }
          attr_accessor :amount

          sig { returns(T.nilable(String)) }
          attr_accessor :campaign

          sig { returns(T.nilable(String)) }
          attr_accessor :cardholder_user_id

          # While client_order_date is sent to EML as a JSON DateTime,
          # there are many classes that could be used which causes a typing
          # challenge. For example, if Rails is in use, we will probably receive
          # a ActiveSupport::TimeWithZone
          sig { returns(T.nilable(T.untyped)) }
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
          sig { returns(T.nilable(T.untyped)) }
          attr_accessor :client_time

          sig { params(client_tracking_id: String).void }
          def client_tracking_id=(client_tracking_id)
            validate_max_length(
              :client_tracking_id, client_tracking_id, 50
            )
            @client_tracking_id = client_tracking_id
          end

          sig { params(location: T::Hash[T.untyped, T.untyped]).void }
          def location=(location)
            @location = EML::UK::Payload::Location.new(location)
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :merchant_group

          sig { returns(T.nilable(String)) }
          attr_accessor :note

          SALES_CHANNELS = T.let(%w[Online InPerson].freeze, T::Array[String])

          sig { returns(T.nilable(String)) }
          attr_accessor :sales_channel
        end
      end
    end
  end
end
