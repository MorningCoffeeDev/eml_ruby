# typed: strict
# frozen_string_literal: true

module EML
  module REST
    class DailyFundingLimitError < ::EML::RESTError
      sig do
        params(
          message: T.nilable(String),
          response: T.nilable(EML::Response)
        ).void
      end
      def initialize(message = nil, response = nil)
        message ||= "The daily maximum load amount has been reached"
        super(message, response)
      end
    end
  end
end
