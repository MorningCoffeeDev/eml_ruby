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

require "eml/error/rest"
require "eml/error/rest/authentication"
require "eml/error/rest/bad_request"
require "eml/error/rest/daily_funding_limit"
require "eml/error/rest/forbidden"
require "eml/error/rest/internal_server"
require "eml/error/rest/not_found"
require "eml/error/rest/unprocessable_entity"
