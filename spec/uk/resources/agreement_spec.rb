# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::UK::Agreement do
  extend EML::Helpers::Config
  configure_uk

  describe ".show" do
    it "gives an ok response" do
      EML::Helpers::VCR.with_cassette("uk/agreement/show") do
        response = described_class.show
        expect(response.success?).to be true
      end
    end

    it "retreives a URL" do
      EML::Helpers::VCR.with_cassette("uk/agreement/show") do
        response = described_class.show
        expect(response.pdf_url.match?(%r{https://.+\.pdf})).to be true
      end
    end
  end
end
