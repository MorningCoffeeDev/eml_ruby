# typed: strict
# frozen_string_literal: true

module EML
  class ConstantTimeCompare
    extend T::Sig

    sig { params(comparison: String, expected: String).returns(T::Boolean) }
    def self.call(comparison, expected)
      new(comparison, expected).call
    end

    sig { params(comparison: String, expected: String).void }
    def initialize(comparison, expected)
      @comparison = comparison
      @expected = expected
    end

    sig { returns(T::Boolean) }
    def call
      return false if @comparison.length != @expected.length

      result = 0

      Hash[[@comparison.bytes, @expected.bytes].transpose].
        each { |x, y| result |= x ^ y }

      result.zero?
    end
  end
end
