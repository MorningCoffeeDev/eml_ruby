# typed: strict
# frozen_string_literal: true

module EML
  module REST
    class BadRequestError < ::EML::RESTError
      sig do
        params(
          message: T.nilable(String),
          response: T.nilable(EML::Response)
        ).void
      end
      def initialize(message = nil, response = nil)
        message ||= "The request could not be Fault information understood " \
          "by the server due to malformed syntax"
        super(message, response)
      end
    end
  end
end
