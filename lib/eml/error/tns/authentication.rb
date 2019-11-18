# typed: strict
# frozen_string_literal: true

module EML
  module TNS
    class AuthenticationError < ::EML::TNSError
      sig { params(message: T.nilable(String)).void }
      def initialize(message = nil)
        message ||= "An unexpected authorization token was supplied in the " \
          "request. Please check that you have set the correct tns_username " \
          "and tns_password in your config and that EML is using the same " \
          "credentials. Failing this, it is possible you are being attacked"
        super
      end
    end
  end
end
