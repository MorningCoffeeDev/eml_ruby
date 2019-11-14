# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Card
        class Register < ::EML::UK::Parameters
          REQUIRED_CONFIG = %i[program].freeze
          OPTIONAL_CONFIG = %i[search_parameter].freeze

          sig { params(program: String).returns(String) }
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
