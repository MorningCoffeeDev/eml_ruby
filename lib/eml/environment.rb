# typed: ignore
# frozen_string_literal: true

# Usually this class wouldn't be called directly, the environment can be managed
# via the EML::Config class or one of it's sub-classes
module EML
  class Environment
    class << self
      def production?
        to_sym == :production
      end

      def test?
        to_sym == :test
      end

      def to_sym
        @to_sym ||= set(default)
      end

      ENVIRONMENTS = %i[production test].freeze

      def set(value)
        return @to_sym = value if ENVIRONMENTS.include?(value)

        error_value = value.is_a?(Symbol) ? ":#{value}" : value.to_s
        raise(
          ArgumentError,
          "#{error_value} is not an acceptable environment; " \
            "please use either :production or :test"
        )
      end

      private

      def default
        return :test if ENV["ENV"] == "test"
        return rails if rails?

        :production
      end

      def rails?
        defined?(Rails)
      end

      def rails
        return :production if Rails.env.production?

        :test
      end
    end
  end
end
