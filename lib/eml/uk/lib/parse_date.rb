# typed: ignore
# frozen_string_literal: true

require "bigdecimal"

module EML
  module UK
    class ParseDate
      extend T::Sig

      def self.call(date_string)
        new(date_string).call
      end

      def initialize(date_string)
        @date_string = date_string
      end

      def call
        return if @date_string.nil?

        matches = @date_string.match(%r(/Date\(((\d{13})([\+\-]\d{4})?)\)/))
        return if matches.nil?

        milliseconds = BigDecimal(matches[2])
        timezone_offset = matches[3]

        time = Time.at(milliseconds / 1000).utc
        return time if timezone_offset.nil?

        time.localtime("#{timezone_offset[0, 3]}:#{timezone_offset[3, 4]}")
      end
    end
  end
end
