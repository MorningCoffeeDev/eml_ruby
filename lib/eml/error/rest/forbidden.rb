# typed: strict
# frozen_string_literal: true

module EML
  module REST
    class ForbiddenError < ::EML::RESTError
      sig do
        params(
          message: T.nilable(String),
          response: T.nilable(EML::Response)
        ).void
      end
      def initialize(message = nil, response = nil)
        message ||= response&.body&.fetch("message", nil)
        message ||= "The user is not authorised to perform the action"
        super(message, response)
      end
    end
  end
end
