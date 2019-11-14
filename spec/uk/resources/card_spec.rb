# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::UK::Card do
  extend EML::Helpers::Config
  configure_uk

  let(:card_id) { ENV["UK_CARD_EXTERNAL_ID"] }
  let(:location) do
    {
      name: "Number 10",
      address1: "10 Downing St",
      city: "Westminster",
      province: "LND",
      postal_code: "SW1A 2AA",
      country: "GBR",
    }
  end

  describe ".activate" do
    let(:payload) do
      {
        amount: 0,
        location: location,
        client_order_date: DateTime.now,
        sales_channel: "Online",
      }
    end

    # it "activates the card" do
    #   EML::Helpers::VCR.with_cassette("uk/card/activation") do
    #     response = described_class.activate(card_id, payload)
    #     expect(response.success?).to be true
    #   end
    # end

    context "when the card is already active" do
      it "raises an UnprocessableEntityError" do
        cassette = "uk/card/activation/unprocessable"
        EML::Helpers::VCR.with_cassette(cassette) do
          expect { described_class.activate(id: card_id, payload: payload) }.
            to raise_error(EML::REST::UnprocessableEntityError)
        end
      end
    end
  end

  describe ".register" do
    let(:payload) do
      location.delete(:name)
      {
        first_name: "Adam",
        last_name: "Quitzon",
        email: "not.an@ddress.fake",
      }.merge(location)
    end

    it "registers the card" do
      EML::Helpers::VCR.with_cassette("uk/card/register") do
        response = described_class.register(id: card_id, payload: payload)
        expect(response.success?).to be true
      end
    end

    context "when the DOB is in the wrong format" do
      it "raises an ArgumentError" do
        payload[:dob] = "31012000"
        cassette = "uk/card/register/dob"
        EML::Helpers::VCR.with_cassette(cassette) do
          expect { described_class.register(id: card_id, payload: payload) }.
            to raise_error(ArgumentError)
        end
      end
    end
  end

  describe ".reload" do
    let(:payload) do
      {
        amount: 1.00,
        location: location,
      }
    end

    it "loads funds onto the card" do
      EML::Helpers::VCR.with_cassette("uk/card/reload") do
        response = described_class.reload(id: card_id, payload: payload)
        expect(response.body["adjusted_balance"]).to eq(1)
      end
    end
  end

  describe ".show" do
    it "gives an ok response" do
      EML::Helpers::VCR.with_cassette("uk/card/show") do
        response = described_class.show(id: card_id)
        expect(response.success?).to be true
      end
    end

    it "returns the information about the card" do
      EML::Helpers::VCR.with_cassette("uk/card/show") do
        response = described_class.show(id: card_id)
        expect(response.body["actual_balance"]).to eq(1)
      end
    end
  end

  describe ".transactions" do
    it "gives an ok response" do
      EML::Helpers::VCR.with_cassette("uk/card/transactions") do
        response = described_class.transactions(id: card_id)
        expect(response.success?).to be true
      end
    end

    it "get the transactions" do
      EML::Helpers::VCR.with_cassette("uk/card/transactions") do
        response = described_class.transactions(id: card_id)
        expect(response.transactions.length).to be > 0
      end
    end
  end

  describe ".unload" do
    let(:payload) do
      {
        amount: 1.00,
        location: location,
        note: "Unloading test",
      }
    end

    it "removes funds from the card" do
      EML::Helpers::VCR.with_cassette("uk/card/unload") do
        response = described_class.unload(id: card_id, payload: payload)
        expect(response.body["adjusted_balance"]).to eq(0)
      end
    end
  end

  describe ".lock" do
    let(:payload) do
      {
        note: "Test suite",
        reason: "Stolen",
      }
    end

    it "locks the card" do
      EML::Helpers::VCR.with_cassette("uk/card/lock") do
        response = described_class.lock(id: card_id, payload: payload)
        expect(response.success?).to be true
      end
    end

    context "when the reason is invalid" do
      before { payload[:reason] = "InvalidReason" }

      it "raises an Argument error" do
        expect { described_class.lock(id: card_id, payload: payload) }.
          to raise_error(ArgumentError)
      end
    end

    context "when the card is already locked" do
      it "raises an UnprocessableEntityError" do
        EML::Helpers::VCR.with_cassette("uk/card/lock/unprocessable") do
          expect { described_class.lock(id: card_id, payload: payload) }.
            to raise_error(EML::REST::UnprocessableEntityError)
        end
      end
    end
  end

  describe ".unlock" do
    let(:payload) do
      { note: "Test suite" }
    end

    it "unlocks the card" do
      EML::Helpers::VCR.with_cassette("uk/card/unlock") do
        response = described_class.unlock(id: card_id, payload: payload)
        expect(response.success?).to be true
      end
    end

    context "when the card is already unlocked" do
      it "raises an UnprocessableEntityError" do
        EML::Helpers::VCR.with_cassette("uk/card/unlock/unprocessable") do
          expect { described_class.unlock(id: card_id, payload: payload) }.
            to raise_error(EML::REST::UnprocessableEntityError)
        end
      end
    end
  end
end
