# typed: strict
# frozen_string_literal: true

require "cgi"

module EML
  module UK
    class APIResource
      extend T::Sig

      LANGUAGE = "en"
      private_constant :LANGUAGE

      sig { params(id: T.nilable(String)).void }
      def initialize(id: nil)
        @id = T.let(id, T.nilable(String))
        @headers = T.let(nil, T.nilable(T::Hash[String, String]))
      end

      sig do
        params(
          action: Symbol,
          endpoint: String,
          payload: T::Hash[Symbol, T.untyped],
          params: T::Hash[Symbol, T.untyped]
        ).returns(EML::Response)
      end
      def request(action, endpoint = "", payload: {}, params: {})
        payload = EML::UK::Payload.convert(self.class, endpoint, payload)
        params = EML::UK::Parameters.convert(self.class, endpoint, params)
        url = resource_url(endpoint)

        response = HTTP.headers(headers).
          public_send(action, url, json: payload.to_h, params: params.to_h)
        response_class(endpoint).new(response, id: @id)
      end

      protected

      sig { params(endpoint: String).returns(String) }
      def resource_url(endpoint)
        endpoint_base = self.class.const_get(:ENDPOINT_BASE)

        if @id.nil?
          "#{domain}/#{endpoint_base}/#{endpoint}"
        else
          "#{domain}/#{endpoint_base}/#{@id}/#{endpoint}"
        end
      end

      private

      sig { returns(T::Hash[Symbol, T.nilable(String)]) }
      def credentials
        config = EML::UK.config
        {
          username: config.username,
          password: config.password,
        }
      end

      sig { returns(String) }
      def domain
        if EML::UK.config.environment.test?
          "https://webservices.xtest.storefinancial.net/api/v1/#{LANGUAGE}"
        else
          "https://webservices.storefinancial.net/api/v1/#{LANGUAGE}"
        end
      end

      sig { returns(T::Hash[String, String]) }
      def headers
        @headers ||= { "Authorization" => "Basic #{base64_credentials}" }
      end

      sig { returns(String) }
      def base64_credentials
        username = credentials[:username]
        password = credentials[:password]
        Base64.encode64("#{username}:#{password}").tr("\n", "")
      end

      sig { params(endpoint: String).returns(T.class_of(EML::Response)) }
      def response_class(endpoint)
        endpoint_class = EML::UK::EndpointClass.(
          class_type: "Responses",
          resource_class: self.class,
          endpoint: endpoint
        )
        endpoint_class || EML::Response
      end
    end
  end
end
