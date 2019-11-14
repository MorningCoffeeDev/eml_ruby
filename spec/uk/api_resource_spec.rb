# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::UK::APIResource do
  extend EML::Helpers::Config
  configure_uk

  describe ".request" do
    context "when the credentials are wrong" do
      before do
        EML::UK.configure do |config|
          config.username = "username"
          config.password = "password"
        end

        allow(described_class).to receive(:const_get).with(:ENDPOINT_BASE).
          and_return("cards")
        allow(EML::UK::Payload).to receive(:convert).and_return({})
        allow(EML::UK::Parameters).to receive(:convert).and_return({})
      end

      after do
        EML::UK.configure do |config|
          config.username = ENV["UK_REST_API_USERNAME"]
          config.password = ENV["UK_REST_API_PASSWORD"]
        end
      end

      let(:cassette) { "uk/api_resource/authentiction_error" }

      it "raises an AuthenticationError" do
        EML::Helpers::VCR.with_cassette(cassette) do
          expect { described_class.new.request(:get, "") }.
            to raise_error(EML::REST::AuthenticationError)
        end
      end
    end
  end
end
