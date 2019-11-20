# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::BasicAuth::Verify do
  subject { described_class.(token, username, password) }

  let(:expected_token) { "dXNlcm5hbWU6cGFzc3dvcmQ=" }
  let(:username) { "username" }
  let(:password) { "password" }

  context "when the token is valid for the username and password" do
    let(:token) { expected_token }

    it { is_expected.to be true }
  end

  context "when the token is not valid for the username and password" do
    let(:token) { "dXNlcm5hbWU6cGFzc3dvcmR=" }

    it { is_expected.to be false }
  end

  context "when the token is not a string" do
    specify do
      expect { described_class.(1, username, password) }.
        to raise_error TypeError
    end
  end

  context "when the username is not a string" do
    specify do
      expect { described_class.(expected_token, 1, password) }.
        to raise_error TypeError
    end
  end

  context "when the password is not a string" do
    specify do
      expect { described_class.(expected_token, username, 1) }.
        to raise_error TypeError
    end
  end
end
