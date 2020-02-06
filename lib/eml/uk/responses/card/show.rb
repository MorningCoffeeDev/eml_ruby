# typed: strong
# frozen_string_literal: true

module EML
  module UK
    module Responses
      module Card
        class Show < ::EML::UK::Response
          extend T::Sig

          field :account_expiration_date
          field :activating_merchant_group_name
          field :activating_merchant_group_uniquetag
          field :activation_amount
          field :activation_country
          field :activation_date
          field :activation_transaction_id
          field :actual_balance
          field :adjusted_balance
          field :agreement_pdf
          field :amf_amount
          field :amf_next_date
          field :amf_start_date
          field :available_balance
          field :bank_name
          field :can_activate
          field :can_redeem
          field :card_id
          field :card_type
          field :currency
          field :currency_info
          field :distributor_refund
          field :expiration_date
          field :has_atm_access
          field :has_pin
          field :is_icc_card
          field :is_organization_registration
          field :is_registered
          field :is_reloadable
          field :is_virtual
          field :pan_last_four
          field :pin_enabled
          field :program_can_register
          field :program_name
          field :program_supports_statements
          field :program_uniquetag
          field :security_code
          field :status
        end
      end
    end
  end
end
