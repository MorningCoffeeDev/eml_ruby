# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Card
        class Unload < ::EML::UK::Parameters
          REQUIRED_CONFIG = T.let(%i[program].freeze, T::Array[Symbol])
          OPTIONAL_CONFIG = T.let(%i[search_parameter].freeze, T::Array[Symbol])

          private

          sig { returns(T.nilable(String)) }
          attr_accessor :program

          sig { params(search_parameter: String).returns(String) }
          def search_parameter=(search_parameter)
            validate_search_parameter(search_parameter)
            @search_parameter = search_parameter
          end
        end
      end
    end
  end
end
