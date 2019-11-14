# typed: false
# frozen_string_literal: true

module EML
  module UK
    class Payload
      module ISO
        private

        def state=(state)
          state_or_province(state, "state")
        end

        def province=(province)
          state_or_province(province, "province")
        end

        def state_or_province(state, title)
          if EML::STATES.include?(state) || state.nil?
            instance_variable_set(:"@#{title}", state)
            return
          end

          raise(
            ArgumentError,
            "Expected #{title} to be an uppercase ISO 3166-2 code " +
            %(but received "#{state}".) + "\n" \
            "Please see http://www.unece.org/cefact/locode/subdivisions.html"
          )
        end

        def country=(country)
          if EML::COUNTRIES.include?(country) || country.nil?
            @country = country
            return
          end

          raise(
            ArgumentError,
            "Expected country to be an uppercase ISO 3166-1 alpha-3 code " +
              %(but received "#{country}".) + "\nPlease see " \
              "https://unstats.un.org/unsd/tradekb/Knowledgebase/Country-Code"
          )
        end
      end
    end
  end
end
