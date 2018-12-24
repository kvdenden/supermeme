module Printful
  class CreateOrder < Base
    def call(confirm: false)
      PrintfulAPI::Order.create(purchase_order_payload, update_existing: true, confirm: confirm)
    end
  end
end
