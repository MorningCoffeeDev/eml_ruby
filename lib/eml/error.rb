# typed: ignore
# frozen_string_literal: true

module EML
  # Error is the base class for more specific EML errors
  class Error < ::StandardError
    extend T::Sig

    attr_reader :message

    sig { params(message: T.nilable(String)).void }
    def initialize(message = nil)
      @message = T.let(message, T.nilable(String))
    end
  end
end
