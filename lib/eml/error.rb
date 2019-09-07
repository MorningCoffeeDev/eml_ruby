# frozen_string_literal: true

require "eml/error/rest"

module EML
  # Error is the base class for more specific EML errors
  class Error
    attr_reader :message

    def initialize(message = nil)
      @message = message
    end
  end
end
