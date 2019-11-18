# typed: strict
# frozen_string_literal: true

module EML
  module BasicAuth
    class Verify
      extend T::Sig

      sig do
        params(
          auth_token: String,
          username: String,
          password: String
        ).returns(T::Boolean)
      end
      def self.call(auth_token, username, password)
        new(auth_token, username, password).call
      end

      sig do
        params(
          auth_token: String,
          username: String,
          password: String
        ).void
      end
      def initialize(auth_token, username, password)
        @auth_token = auth_token
        @username = username
        @password = password
      end

      sig { returns(T::Boolean) }
      def call
        request_token = parse_auth_token
        expected_token = Generate.(@username, @password)

        ::EML::ConstantTimeCompare.(request_token, expected_token)
      end

      private

      def parse_auth_token
        @auth_token.sub(/^[^\s]+\s/, "")
      end
    end
  end
end
