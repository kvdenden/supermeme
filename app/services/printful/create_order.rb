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
          zip: order.address.zip_code,
          state_code: order.address.state_code,
          country_code: order.address.country_code,
        },
        items: order.line_items.map { |item| line_item_payload(item) },
        confirm: Rails.configuration.printful[:confirm_order]
      }
    end

    def line_item_payload(item)
      {
        variant_id: item.variant.external_id,
        quantity: item.quantity,
        retail_price: item.price,
        name: item.title,
        files: [{
          url: Rails.application.routes.url_helpers.product_variant_image_url(variant_id: item.variant_id, text: item.text)
        }]
      }
    end
  end
end
