module Printful
  class CreateOrder
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def call
      payload = purchase_order_payload
      PrintfulAPI::Order.create(payload)
    end

    private

    def purchase_order_payload
      {
        external_id: order.id,
        recipient: {
          name: order.name,
          email: order.email,
          address1: order.address.street1,
          address2: order.address.street2,
          city: order.address.city,
          state_name: order.address.state,
          country_code: order.address.country_code,
        },
        items: order.line_items.map { |item| line_item_payload(item) }
      }
    end

    def line_item_payload(item)
      {
        variant_id: item.variant.external_id,
        quantity: item.quantity,
        files: [{
          url: Rails.application.routes.url_helpers.product_variant_image_url(variant_id: item.variant_id, text: item.text)
        }]
      }
    end
  end
end
