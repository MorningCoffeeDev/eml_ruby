# typed: strict
# frozen_string_literal: true

module EML
  module Helpers
    module TNSUK
      extend T::Sig

      TRANSACTION = {
        "TransactionId" => 123_456_789,
        "EmlId" => nil,
        "TransactionTime" => "2020-01-01T00:00:00.1234567-06:00",
        "TransactionAmount" => 1.0,
        "TransactionDescription" => "Unload",
        "TransactionCurrency" => "GBP",
        "TransactionLocation" => "",
        "Reason" => "Active",
        "Result" => "Unlocked",
        "Note" => "Testing",
        "MerchantCategoryCode" => "",
        "MerchantCountry" => "",
        "PosTransactionTime" => nil,
        "OriginalTransactionDate" => nil,
        "AuthorizationRequestId" => "",
        "RetrievalReferenceNumber" => "",
        "Card" => {
          "AvailableBalance" => 1.23,
          "ExternalId" => "ABCDEFGHIJKLMNOP",
          "ClientTrackingId" => "ABCDEFGHIJ",
          "Program" => "Program123",
          "MerchantGroup" => "Merchant12",
          "Currency" => "GBP",
          "CarrierNumber" => nil,
        },
      }.freeze

      RESPONSE = {
        Transactions: [TRANSACTION],
      }.freeze
    end
  end
end
