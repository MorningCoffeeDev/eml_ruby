# typed: strict
# frozen_string_literal: true

module EML
  class Response
    extend T::Sig

    sig { params(field_name: Symbol).void }
    def self.field(field_name)
      define_method(field_name) do
        string_name = field_name.to_s
        body[string_name]
      end
    end

    sig { params(response: HTTP::Response, id: T.nilable(String)).void }
    def initialize(response, id: nil)
      @response = T.let(response, HTTP::Response)
      @body = T.let(nil, T.nilable(String))
      @http_status = T.let(nil, T.nilable(Integer))
      @url = T.let(nil, T.nilable(String))
      raise_error(id: id) unless http_status == 200
    end

    # TODO: sometimes we get a string and sometimes a hash. When it's a hash,
    #       there should be a custom response object
    sig { returns(T.untyped) }
    def body
      @body ||= JSON.parse(@response.body.to_s)
    rescue JSON::ParserError
      @body = ""
    end

    sig { returns(T.nilable(String)) }
    def error
      body.fetch("message", nil) if body.respond_to?(:fetch)
    end

    sig { returns(T::Hash[Symbol, String]) }
    def headers
      @response.headers
    end

    sig { returns(Integer) }
    def http_status
      @http_status ||= @response.status.code
    end

    sig { returns(T::Boolean) }
    def success?
      http_status == 200
    end

    sig { returns(String) }
    def url
      @url ||= T.unsafe(@response).url.to_s
    end

    private

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    sig { params(id: T.nilable(String)).returns(EML::RESTError) }
    def raise_error(id: nil)
      check_for_incorrectly_categorised_errors

      case http_status
      when 400
        raise T.unsafe(EML::REST::BadRequestError).new(error, self)
      when 401
        raise T.unsafe(EML::REST::AuthenticationError).new(nil, self)
      when 403
        raise T.unsafe(EML::REST::ForbiddenError).new(nil, self)
      when 404
        raise T.unsafe(EML::REST::NotFoundError).new(nil, self, id: T.must(id))
      when 500
        process_internal_server_error
        raise T.unsafe(EML::REST::InternalServerError).new(error, self)
      end

      raise T.unsafe(EML::RESTError).
        new("Unknown error (#{http_status}): #{error}", self)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    sig { returns(T.nilable(EML::RESTError)) }
    def check_for_incorrectly_categorised_errors
      if error.match?(/is not in (the proper|a valid) status/)
        raise T.unsafe(EML::REST::UnprocessableEntityError).new(error, self)
      end
    end

    sig { returns(T.nilable(EML::RESTError)) }
    def process_internal_server_error
      case error
      when "Card reload could not be completed because it violated the " \
        "funding limit: 'Daily Max Reload Amount Funding Limit'"
        raise T.unsafe(EML::REST::DailyFundingLimitError).new(nil, self)
      when "Invalid username or password."
        raise T.unsafe(EML::REST::AuthenticationError).new(nil, self)
      end
    end
  end
end
