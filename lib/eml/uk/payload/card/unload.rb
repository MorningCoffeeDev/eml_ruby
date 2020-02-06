# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Unload < ::EML::UK::Payload
          REQUIRED_CONFIG =
            T.let(%i[merchant_group].freeze, T::Array[Symbol])
          REQUIRED_VALUES =
            T.let(%i[amount location.country note].freeze, T::Array[Symbol])

          sig { params(payload: T::Hash[Symbol, T.untyped]).void }
          def initialize(payload)
            super

            @location = T.let(nil, T.nilable(EML::UK::Payload::Location))
          end

          private

          sig { returns(T.nilable(Numeric)) }
          attr_accessor :amount

          # While client_time is sent to EML as a JSON DateTime, there are many
          # classes that could be used which causes a typing challenge. For
          # example, if Rails is in use, we will probably receive a
          # ActiveSupport::TimeWithZone
          sig { returns(T.nilable(T.untyped)) }
          attr_accessor :client_time

          sig { params(location: T::Hash[T.untyped, T.untyped]).void }
          def location=(location)
            @location = EML::UK::Payload::Location.new(location)
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :merchant_group

          sig { returns(T.nilable(String)) }
          attr_accessor :note
        end
      end
    end
  end
end
