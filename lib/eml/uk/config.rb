# frozen_string_literal: true

module EML
  module UK
    class << self
      def configure
        yield config
      end

      def config
        @config ||= Config.new
      end
    end

    class Config
      attr_accessor :username
      attr_accessor :password
      attr_accessor :merchant
      attr_accessor :program
    end
  end
end
