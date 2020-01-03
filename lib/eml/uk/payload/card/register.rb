# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module Card
        class Register < ::EML::UK::Payload
          include ISO

          REQUIRED_VALUES =
            %i[first_name last_name address1 city country email].freeze

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

          sig { params(city: String).void }
          def city=(city)
            validate_max_length(:city, city, 255)
            @city = city
          end

          sig { params(dob: T.any(Date, String, Time)).void }
          def dob=(dob)
            dob = dob.strftime("%m%d%Y") if dob.respond_to?(:strftime)
            validate_dob(dob)
            @dob = dob
          end

          sig { params(email: String).void }
          def email=(email)
            validate_max_length(:email, email, 255)
            @email = email
          end

          sig { params(phone: String).void }
          def phone=(phone)
            validate_max_length(:phone, phone, 20)
            @phone = phone
          end

          sig { params(postal_code: String).returns(String) }
          attr_accessor :postal_code
        end
      end
    end
  end
end
