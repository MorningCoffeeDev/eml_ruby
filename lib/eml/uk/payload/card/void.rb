# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Void < ::EML::UK::Payload
          REQUIRED_CONFIG = %i[merchant_group].freeze
          REQUIRED_VALUES = %i[note].freeze

          private

          sig { params(merchant_group: String).returns(String) }
          attr_accessor :merchant_group

          sig { params(note: String).returns(String) }
          attr_accessor :note
        end
      end
    end
  end
end
