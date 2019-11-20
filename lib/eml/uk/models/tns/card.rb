# typed: true
# frozen_string_literal: true

module EML
  module UK
    module Models
      module TNS
        class Card < ::EML::Model
          fields(
            "AvailableBalance" => :availableBalance,
            "CarrierNumber" => :carrierNumber,
            "ClientTrackingId" => :clientTrackingId,
            "Currency" => :currency,
            "ExternalId" => :externalId,
            "Program" => :program,
            "MerchantGroup" => :merchantGroup
          )
        end
      end
    end
  end
end
