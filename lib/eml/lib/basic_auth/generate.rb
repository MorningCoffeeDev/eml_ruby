# typed: strict
# frozen_string_literal: true

require "base64"

module EML
  module BasicAuth
    class Generate
      extend T::Sig

      sig do
        params(
          username: String,
          password: String,
          prefix: String
        ).returns(String)
      end
      def self.call(username, password, prefix: "")
        new(username, password, prefix: prefix).call
      end

      sig do
        params(
          username: String,
          password: String,
          prefix: String
        ).void
      end
      def initialize(username, password, prefix: "")
        @username = T.let(username, String)
        @password = T.let(password, String)
        @prefix = T.let(prefix, String)
      end

      sig { returns(String) }
      def call
        token = Base64.encode64("#{@username}:#{@password}").tr("\n", "")
        "#{@prefix}#{token}"
      end
    end
  end
end
