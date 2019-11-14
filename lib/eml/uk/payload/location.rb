# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      class Location < ::EML::Payload
        extend T::Sig
        include ISO

        private

        sig { params(name: String).returns(String) }
        attr_accessor :name

        sig { params(address1: String).returns(String) }
        attr_accessor :address1

        sig { params(address2: String).returns(String) }
        attr_accessor :address2

        sig { params(city: String).returns(String) }
        attr_accessor :city

        sig { params(postal_code: String).returns(String) }
        attr_accessor :postal_code
      end
    end
  end
end
