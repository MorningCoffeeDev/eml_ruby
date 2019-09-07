# frozen_string_literal: true

module EML
  module APIOperation
    module Create
      def create(params = {})
        request(:post, resource_url, params)
      end
    end
  end
end
