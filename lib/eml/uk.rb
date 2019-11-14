# typed: strong
# frozen_string_literal: true

module EML
  module UK
  end
end

require "eml/uk/api_resource"
require "eml/uk/config"

require "eml/uk/lib/endpoint_class"
require "eml/uk/lib/parse_date"

require "eml/uk/model/transaction"

require "eml/uk/parameters"
require "eml/uk/parameters/agreement/show"
require "eml/uk/parameters/card/activation"
require "eml/uk/parameters/card/show"
require "eml/uk/parameters/card/lock"
require "eml/uk/parameters/card/register"
require "eml/uk/parameters/card/reload"
require "eml/uk/parameters/card/transaction"
require "eml/uk/parameters/card/unload"
require "eml/uk/parameters/card/unlock"

require "eml/uk/payload"
require "eml/uk/payload/agreement/show"
require "eml/uk/payload/iso"
require "eml/uk/payload/contactentity"
require "eml/uk/payload/location"
require "eml/uk/payload/nil"
require "eml/uk/payload/card/activation"
require "eml/uk/payload/card/show"
require "eml/uk/payload/card/lock"
require "eml/uk/payload/card/register"
require "eml/uk/payload/card/reload"
require "eml/uk/payload/card/transaction"
require "eml/uk/payload/card/unload"
require "eml/uk/payload/card/unlock"
require "eml/uk/payload/card/void"

require "eml/uk/resources/agreement"
require "eml/uk/resources/card"

require "eml/uk/response"
require "eml/uk/responses/agreement/show"
require "eml/uk/responses/card/reload"
require "eml/uk/responses/card/show"
require "eml/uk/responses/card/transaction"
