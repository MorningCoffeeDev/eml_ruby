# typed: ignore
# frozen_string_literal: true

module EML
  module UK
    class << self
      extend T::Sig

      sig { void }
      def configure
        yield config
      end

      sig { returns(Config) }
      def config
        @config ||= T.let(Config.new, Config)
      end
    end

    class Config < ::EML::Config
      extend T::Sig

      sig { returns(String) }
      attr_accessor :merchant_group

      sig { returns(String) }
      attr_accessor :program

      sig { returns(String) }
      attr_accessor :rest_username

      sig { returns(String) }
      attr_accessor :rest_password

      sig { returns(String) }
      attr_accessor :search_parameter

      sig { returns(String) }
      attr_accessor :tns_username

      sig { returns(String) }
      attr_accessor :tns_password

      private

      sig { params(param: Symbol).void }
      def require_error(param)
        raise(
          ArgumentError,
          "#{param} is required but hasn't been set.\n" \
            "EML::UK::Config.configuration do |config|\n" +
            %(  config.#{param} = "value") + "\n" \
            "end"
        )
      end
    end
  end
end
