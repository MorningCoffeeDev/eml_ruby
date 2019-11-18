# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::BasicAuth::Generate do
  let(:expected_token) { "dXNlcm5hbWU6cGFzc3dvcmQ=" }

  it "produces a base64 encoded string" do
    token = described_class.("username", "password")
    expect(token).to eq expected_token
  end

  context "when providing a prefix" do
    it "prepends the prefix to the token" do
      token = described_class.("username", "password", prefix: "Basic ")
      expect(token).to eq "Basic #{expected_token}"
    end
  end

  context "when the username is not a string" do
    specify do
      expect { described_class.(1, "password") }.to raise_error TypeError
    end
  end

  context "when the password is not a string" do
    specify do
      expect { described_class.("username", 1) }.to raise_error TypeError
    end
  end

  context "when the prefix is not a string" do
    specify do
      expect { described_class.("username", "password", prefix: 1) }.
        to raise_error TypeError
    end
  end
end
