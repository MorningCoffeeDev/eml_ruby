# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Agreement
        class Show < ::EML::UK::Parameters
          def initialize(params)
            params[:client_language] ||= "en"
            super
          end

          private

          sig { params(client_language: String).returns(String) }
          attr_accessor :client_language
        end
      end
    end
  end
end
