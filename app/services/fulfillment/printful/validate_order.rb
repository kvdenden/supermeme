# frozen_string_literal: true

module Fulfillment
  module Printful
    class ValidateOrder < Base
      def call
        payload = purchase_order_payload(include_id: false)
        PrintfulAPI.request(:POST, "/orders/estimate-costs", data: payload)
        true
      rescue PrintfulApiException => e
        order.errors.add(:base, e.message)
        false
      end
    end
  end
end
