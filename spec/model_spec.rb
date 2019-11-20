# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::Model do
  before do
    test_model = Class.new(::EML::Model) do
      fields(
        "First" => :first,
        "Second" => :second,
        "Third" => :third,
        "Fourth" => :fourth,
        "Fifth" => :fifth
      )
    end
    stub_const("TestModel", test_model)
  end

  let(:params) do
    {
      "First" => "A",
      "Second" => 1,
      "Third" => Time.now,
      "Fourth" => { a: "a" },
      "Fifth" => %w[a b],
    }
  end

  describe "#to_h" do
    let(:expected_hash) do
      {
        first: params["First"],
        second: params["Second"],
        third: params["Third"],
        fourth: params["Fourth"],
        fifth: params["Fifth"],
      }
    end

    it "converts the model to a hash" do
      expect(TestModel.new(params).to_h).to eq(expected_hash)
    end
  end

  describe "#to_json" do
    let(:expected_string) do
      {
        first: params["First"],
        second: params["Second"],
        third: params["Third"],
        fourth: params["Fourth"],
        fifth: params["Fifth"],
      }.to_json
    end

    it "converts the model to a JSON string" do
      expect(TestModel.new(params).to_json).to eq(expected_string)
    end
  end
end
