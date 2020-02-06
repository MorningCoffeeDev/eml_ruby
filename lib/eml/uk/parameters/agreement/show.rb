# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Agreement
        class Show < ::EML::UK::Parameters
          sig { params(params: T::Hash[T.untyped, T.untyped]).void }
          def initialize(params)
            params[:client_language] ||= "en"
            super
          end

          private

          sig { returns(T.nilable(String)) }
          attr_accessor :client_language
        end
      end
    end
  end
end
