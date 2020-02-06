# typed: false
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
      @comparison = T.let(comparison, String)
      @expected = T.let(expected, String)
    end

    sig { returns(T::Boolean) }
    def call
      return false if @comparison.length != @expected.length

      result = 0

      transposed = [@comparison.bytes, @expected.bytes].transpose
      Hash[transposed].each { |x, y| result |= x ^ y }

      result.zero?
    end
  end
end
