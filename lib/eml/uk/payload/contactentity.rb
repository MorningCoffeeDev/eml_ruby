# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      class Contactentity < ::EML::Payload
        REQUIRED_VALUES = %i[first_name last_name address1 city country].freeze

        include ISO

        private

        sig { params(first_name: String).void }
        def first_name=(first_name)
          validate_max_length(:first_name, first_name, 50)
          @first_name = first_name
        end

        sig { params(last_name: String).void }
        def last_name=(last_name)
          validate_max_length(:last_name, last_name, 50)
          @last_name = last_name
        end

        sig { params(address1: String).void }
        def address1=(address1)
          validate_max_length(:address1, address1, 255)
          @address1 = address1
        end

        sig { params(address2: String).void }
        def address2=(address2)
          validate_max_length(:address2, address2, 255)
          @address2 = address2
        end

        sig { params(city: String).returns(String) }
        attr_accessor :city

        sig { params(postal_code: String).returns(String) }
        attr_accessor :postal_code

        sig { params(phone: String).void }
        def phone=(phone)
          validate_max_length(:phone, phone, 20)
          @phone = phone
        end

        sig { params(email: String).void }
        def email=(email)
          validate_max_length(:email, email, 255)
          @email = email
        end

        sig { params(dob: String).void }
        def dob=(dob)
          validate_max_length(:dob, dob, 8)
          @dob = dob
        end
      end
    end
  end
end
