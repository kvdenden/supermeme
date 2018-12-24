module Printful
  class Base
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def purchase_order_payload
      {
        external_id: Rails.env.development? ? "#{order.id}_dev" : order.id,
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
        retail_costs: {
          subtotal: order.subtotal,
          shipping: order.shipping_fee,
          total: order.total
        }
      }
    end

    def line_item_payload(item)
      {
        external_id: Rails.env.development? ? "#{item.id}_dev" : item.id,
        variant_id: item.variant.external_id,
        quantity: item.quantity,
        retail_price: item.unit_price,
        name: item.title,
        files: [{
          url: Rails.application.routes.url_helpers.product_variant_image_url(variant_id: item.variant_id, text: item.text)
        }]
      }
    end
  end
end