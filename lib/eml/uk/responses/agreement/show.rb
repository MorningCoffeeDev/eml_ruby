# typed: strong
# frozen_string_literal: true

module EML
  module UK
    module Responses
      module Agreement
        class Show < ::EML::UK::Response
          field :file_name
          field :pdf_url
          field :txt_url
        end
      end
    end
  end
end
