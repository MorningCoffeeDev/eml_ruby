# typed: strict
# frozen_string_literal: true

module EML
  module UK
    module TNS
      class ProcessRequest
        extend T::Sig

        sig do
          params(
            auth_token: String,
            parameters: T::Hash[Symbol, T.untyped]
          ).returns(EML::UK::TNS::Response)
        end
        def self.call(auth_token, parameters)
          new(auth_token, parameters).call
        end

        sig do
          params(
            auth_token: String,
            parameters: T::Hash[Symbol, T.untyped]
          ).void
        end
        def initialize(auth_token, parameters)
          @auth_token = auth_token
          @parameters = parameters
        end

        sig { returns(EML::UK::TNS::Response) }
        def call
          verify_auth_token
          EML::UK::TNS::Response.new(@parameters)
        end

        private

        sig { void }
        def verify_auth_token
          valid = ::EML::BasicAuth::Verify.(
            @auth_token,
            credentials[:username],
            credentials[:password]
          )
          return if valid == true

          raise ::EML::TNS::AuthenticationError
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def credentials
          @credentials ||= begin
            config = EML::UK.config
            {
              username: config.tns_username,
              password: config.tns_password,
            }
          end
        end
      end
    end
  end
end
