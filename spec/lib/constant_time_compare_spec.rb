# typed: ignore
# frozen_string_literal: true

RSpec.describe EML::ConstantTimeCompare do
  subject(:compare) { described_class.(expected, comparison) }

  let(:expected) { "expected" }

  context "with matching strings" do
    let(:comparison) { expected }

    it { is_expected.to be true }
  end

  context "with unmatched strings of equal length" do
    let(:comparison) { "expectee" }

    it { is_expected.to be false }
  end

  context "with unmatched strings of unequal length" do
    let(:comparison) { "unexpected" }

    it { is_expected.to be false }
  end

  context "when a non-string parameter is provided" do
    context "when the expected value is an integer" do
      let(:expected) { 1 }
      let(:comparison) { "expected" }

      specify { expect { compare }.to raise_error TypeError }
    end

    context "when the comparison value is an integer" do
      let(:comparison) { 1 }

      specify { expect { compare }.to raise_error TypeError }
    end
  end
end
