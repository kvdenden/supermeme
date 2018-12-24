module Printful
  class CreateOrder < Base
    def call
      PrintfulAPI::Order.create(purchase_order_payload, update_existing: true)
    end
  end
end
