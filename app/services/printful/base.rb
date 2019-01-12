# frozen_string_literal: true

module Printful
  class Base
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def purchase_order_payload(include_id: true)
      {
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
        items: order.line_items.map { |item| line_item_payload(item, include_id: include_id) },
        retail_costs: {
          subtotal: order.subtotal,
          shipping: order.shipping_fee,
          total: order.total
        }
      }.tap { |h| h.merge!(external_id: external_id(order)) if include_id }
    end

    protected

    def line_item_payload(item, include_id: true)
      {
        variant_id: printful_id(item.variant),
        quantity: item.quantity,
        retail_price: item.unit_price,
        name: item.title,
        files: [{
          url: Rails.application.routes.url_helpers.product_variant_image_url(variant_id: item.variant_id, text: item.text)
        }]
      }.tap { |h| h.merge!(external_id: external_id(item)) if include_id }
    end

    def external_id(model)
      Rails.env.development? ? "#{model.id}_dev" : model.id
    end

    def printful_id(variant)
      variant.fulfiller_variants.find_by!(fulfiller: Fulfiller.printful).external_id
    end
  end
end
