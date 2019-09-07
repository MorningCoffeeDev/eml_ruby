# frozen_string_literal: true

module EML
  class APIResource
    def resource_url
      if id.present?
        "#{self::ENDPOINT_BASE}/#{id}"
      else
        self::ENDPOINT_BASE
      end
    end
  end
end
