# typed: strict
# frozen_string_literal: true

module EML
  module Helpers
    module Config
      extend T::Sig

      sig { void }
      def configure_uk
        EML::UK.configure do |config|
          config.merchant_group = ENV["UK_REST_API_MERCHANT_GROUP"]
          config.program = ENV["UK_REST_API_PROGRAM"]
          config.rest_username = ENV["UK_REST_API_USERNAME"]
          config.rest_password = ENV["UK_REST_API_PASSWORD"]
          config.search_parameter = ENV["UK_REST_API_SEARCH_PARAMETER"]
          config.tns_username = ENV["UK_TNS_USERNAME"]
          config.tns_password = ENV["UK_TNS_PASSWORD"]
        end
      end
    end
  end
end
