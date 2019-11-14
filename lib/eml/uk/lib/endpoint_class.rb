# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class EndpointClass < ::EML::EndpointClass
      extend T::Sig

      private

      sig { returns(String) }
      def action_class_name
        return "Show" if @endpoint.empty?

        super
      end
    end
  end
end
