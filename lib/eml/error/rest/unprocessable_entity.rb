# typed: strict
# frozen_string_literal: true

module EML
  module REST
    class UnprocessableEntityError < ::EML::RESTError
      sig do
        params(
          message: T.nilable(String),
          response: T.nilable(EML::Response)
        ).void
      end
      def initialize(message = nil, response = nil)
        message ||= "The server understood the request but it could not be " \
          "processed (possibly semantically erroneous)"
        super(message, response)
      end
    end
  end
end
