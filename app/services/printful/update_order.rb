module Printful
  class UpdateOrder < Base
    def call(confirm: false)
      payload = purchase_order_payload(include_id: true)
      PrintfulAPI::Order.create(payload, update_existing: true, confirm: confirm)
    end
  end
end
