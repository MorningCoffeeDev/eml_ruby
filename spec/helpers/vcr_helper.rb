# typed: true
# frozen_string_literal: true

module EML
  module Helpers
    module VCR
      extend T::Sig

      RE_RECORD_INTERVAL = T.let(86_400, Integer)

      sig { params(path: String).void }
      def self.with_cassette(path)
        ::VCR.use_cassette(path, re_record_interval: RE_RECORD_INTERVAL) do
          yield
        end
      end
    end
  end
end
