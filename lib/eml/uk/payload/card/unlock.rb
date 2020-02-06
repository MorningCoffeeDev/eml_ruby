# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Unlock < ::EML::UK::Payload
          REQUIRED_CONFIG = T.let(%i[merchant_group].freeze, T::Array[Symbol])
          REQUIRED_VALUES = T.let(%i[note].freeze, T::Array[Symbol])

          private

          sig { returns(T.nilable(String)) }
          attr_accessor :merchant_group

          sig { returns(T.nilable(String)) }
          attr_accessor :note
        end
      end
    end
  end
end
