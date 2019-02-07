# frozen_string_literal: true

module Fulfillment
  module Printful
    class CreateOrder < Base
      def call(confirm: false)
        payload = purchase_order_payload(include_id: true)
        PrintfulAPI::Order.create(payload, confirm: confirm)
      end
    end
  end
end
