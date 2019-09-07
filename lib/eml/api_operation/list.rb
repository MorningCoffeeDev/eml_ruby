# frozen_string_literal: true

module EML
  module APIOperation
    module List
      def list(filters = {})
        request(:get, resource_url, filters)
      end
    end
  end
end
