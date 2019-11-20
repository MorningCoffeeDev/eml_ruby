# typed: strict
# frozen_string_literal: true

module EML
  module BasicAuth
    class Verify
      extend T::Sig

      sig do
        params(
          auth_token: T.nilable(String),
          username: String,
          password: String
        ).returns(T::Boolean)
      end
      def self.call(auth_token, username, password)
        new(auth_token, username, password).call
      end

      sig do
        params(
          auth_token: T.nilable(String),
          username: String,
          password: String
        ).void
      end
      def initialize(auth_token, username, password)
        @auth_token = T.let(auth_token || "", String)
        @username = T.let(username, String)
        @password = T.let(password, String)
      end

      sig { returns(T::Boolean) }
      def call
        request_token = parse_auth_token
        expected_token = Generate.(@username, @password)

        ::EML::ConstantTimeCompare.(request_token, expected_token)
      end

      private

      sig { returns(String) }
      def parse_auth_token
        @auth_token.sub(/^[^\s]+\s/, "")
      end
    end
  end
end
