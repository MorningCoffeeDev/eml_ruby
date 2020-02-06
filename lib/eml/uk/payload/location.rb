# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Payload
      class Location < ::EML::Payload
        extend T::Sig
        include ISO

        private

        sig { returns(T.nilable(String)) }
        attr_accessor :name

        sig { returns(T.nilable(String)) }
        attr_accessor :address1

        sig { returns(T.nilable(String)) }
        attr_accessor :address2

        sig { returns(T.nilable(String)) }
        attr_accessor :city

        sig { returns(T.nilable(String)) }
        attr_accessor :postal_code
      end
    end
  end
end
