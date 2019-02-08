# frozen_string_literal: true

module Fulfillment
  module Printful
    class CreateOrder < Base
      def call(confirm: false)
        payload = purchase_order_payload(include_id: true)
        order = PrintfulAPI::Order.create(payload, confirm: confirm)
        order.id
      end
    end
  end
end
