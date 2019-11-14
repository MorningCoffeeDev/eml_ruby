# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::Config do
  let(:config) { described_class.new }

  describe "#environment=" do
    after { config.environment = :test }

    it "sets the environment" do
      expect { config.environment = :production }.to(
        change(config.environment, :production?).from(false).to(true)
      )
    end

    context "when in invalid environment is supplied" do
      specify do
        expect { config.environment = :invalid }.to raise_error(ArgumentError)
      end

      specify do
        expect { config.environment = "production" }.to raise_error(TypeError)
      end
    end
  end
end
