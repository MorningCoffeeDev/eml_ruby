# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::UK::TNS::ProcessRequest do
  extend EML::Helpers::Config
  configure_uk

  extend EML::Helpers::TNSUK

  let(:token) { "dXNlcm5hbWU6cGFzc3dvcmQ=" }
  let(:params) { EML::Helpers::TNSUK::RESPONSE }

  context "when the token is invalid" do
    let(:auth_error) { ::EML::TNS::AuthenticationError }
    let(:token) { "dXNlcm5hbWU6cGFzc3dvcmR=" }

    specify do
      expect { described_class.(token, params) }.to raise_error auth_error
    end
  end

  context "with a single card transaction" do
    let(:transactions) { described_class.(token, params).transactions }
    let(:transaction) { transactions.first }

    it "sets transactions" do
      expect(transactions).not_to be nil
    end

    it "has exactly 1 transaction" do
      expect(transactions.length).to be 1
    end

    it "sets card" do
      expect(transaction.card).not_to be nil
    end

    it "does not set cards" do
      expect(transaction.cards.length).to be 0
    end
  end
end
