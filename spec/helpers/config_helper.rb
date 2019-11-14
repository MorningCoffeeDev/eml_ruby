# typed: strict
# frozen_string_literal: true

module EML
  module Helpers
    module Config
      extend T::Sig

      sig { void }
      def configure_uk
        EML::UK.configure do |config|
          config.username = ENV["UK_REST_API_USERNAME"]
          config.password = ENV["UK_REST_API_PASSWORD"]
          config.merchant_group = ENV["UK_REST_API_MERCHANT_GROUP"]
          config.program = ENV["UK_REST_API_PROGRAM"]
          config.search_parameter = ENV["UK_REST_API_SEARCH_PARAMETER"]
        end
      end
    end
  end
end
