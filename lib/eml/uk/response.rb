# typed: strict
# frozen_string_literal: true

module EML
  module UK
    class Response < ::EML::Response
      class << self
        extend T::Sig

        protected

        sig { params(field_name: Symbol).void }
        def field(field_name)
          string_name = field_name.to_s
          return date_field(field_name) if string_name.include?("date")

          super
        end

        sig { params(field_name: Symbol).void }
        def date_field(field_name)
          define_method(field_name) do
            ::EML::UK::ParseDate.(T.unsafe(self).body[field_name.to_s])
          end
        end
      end
    end
  end
end
