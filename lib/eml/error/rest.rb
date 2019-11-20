# typed: strict
# frozen_string_literal: true

module EML
  # RESTError is the parent class for errors related to connections to the EML
  # REST Web Services APIs
  class RESTError < Error
    extend T::Sig

    sig do
      params(
        message: T.nilable(String),
        response: T.nilable(EML::Response)
      ).void
    end
    def initialize(message = nil, response = nil)
      super(message)

      @response = T.let(response, T.nilable(EML::Response))
    end

    sig { returns(T.nilable(String)) }
    def http_body
      @response&.error || @response&.body&.to_s
    end

    sig { returns(T.nilable(T::Hash[Symbol, String])) }
    def http_headers
      @response&.headers
    end

    sig { returns(T.nilable(Integer)) }
    def http_status
      @response&.http_status
    end

    sig { returns(T.nilable(String)) }
    def url
      @response&.url&.to_s
    end
  end
end
