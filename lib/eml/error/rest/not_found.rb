# typed: strict
# frozen_string_literal: true

module EML
  module REST
    class NotFoundError < ::EML::RESTError
      sig do
        params(
          message: T.nilable(String),
          response: T.nilable(EML::Response),
          id: String
        ).void
      end
      def initialize(message = nil, response = nil, id:)
        message ||= %(A record could not be found with ID "#{id}")
        super(message, response)
      end
    end
  end
end
