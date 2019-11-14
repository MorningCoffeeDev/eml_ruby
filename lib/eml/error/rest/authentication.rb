# typed: strict
# frozen_string_literal: true

module EML
  module REST
    class AuthenticationError < ::EML::RESTError
      sig do
        params(
          message: T.nilable(String),
          response: T.nilable(EML::Response)
        ).void
      end
      def initialize(message = nil, response = nil)
        message ||= "Your credentials were rejected by the server. " \
          "Please confirm you have set your username and password in the " \
          "appropriate country configuration"
        super(message, response)
      end
    end
  end
end
