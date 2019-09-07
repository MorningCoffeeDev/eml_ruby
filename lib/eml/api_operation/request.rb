# frozen_string_literal: true

module EML
  module APIOperation
    module Request
      module ClassMethods
        def request(method, url, params = {})
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
