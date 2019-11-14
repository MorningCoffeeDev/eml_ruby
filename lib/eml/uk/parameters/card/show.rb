# typed: true
# frozen_string_literal: true

module EML
  module UK
    class Parameters
      module Card
        class Show < ::EML::UK::Parameters
          REQUIRED_CONFIG = %i[program].freeze
          OPTIONAL_CONFIG = %i[search_parameter].freeze

          FIELDS_OPTIONS = %w[
            account_expiration_date
            activating_merchant_group_name
            activating_merchant_group_uniquetag
            activation_amount
            activation_country
            activation_date
            activation_transaction_Id
            actual_balance
            adjusted_balance
            agreement_txt
            agreement_pdf
            agreement_pdf_fileName
            amf_amount
            amf_start_date
            amf_next_date
            available_balance
            bank_name
            barcode_image
            can_activate
            can_redeem
            card_image
            card_type
            client_tracking_id
            currency
            cvv2
            distributor_refund
            expiration_date
            has_atm_access
            has_pin
            id
            is_icc_card
            is_organization_registration
            is_registered
            is_reloadable
            is_virtual
            pan
            pan_last_four
            pin_enabled
            print_text
            program_can_register
            program_name
            program_uniquetag
            promotion_balance
            promotion_expiration
            promotion_type_id
            security_code
            status
            uri
            unload_to_ach_fee
          ].freeze

          sig { params(fields: T::Array[String]).returns(String) }
          def fields=(fields)
            unless fields.first == "all"
              fields.each do |field|
                validate_array("fields", field, FIELDS_OPTIONS)
              end
            end

            @fields = fields.join(",")
          end

          sig { params(log_balance_inquiry: T::Boolean).returns(String) }
          def log_balance_inquiry=(log_balance_inquiry)
            @log_balance_inquiry = log_balance_inquiry.inspect
          end

          sig { params(only_valid_status: T::Boolean).returns(String) }
          def only_valid_status=(only_valid_status)
            @only_valid_status = only_valid_status.inspect
          end

          sig { params(program: String).returns(String) }
          attr_accessor :program

          sig { params(search_parameter: String).returns(String) }
          def search_parameter=(search_parameter)
            validate_search_parameter(search_parameter)
            @search_parameter = search_parameter
          end

          sig { params(security_code: String).returns(String) }
          attr_accessor :security_code
        end
      end
    end
  end
end
