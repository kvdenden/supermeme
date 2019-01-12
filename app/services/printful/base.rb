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
        variant_id: printful_variant(item.variant).external_id,
        quantity: item.quantity,
        retail_price: item.unit_price,
        name: item.title,
        files: [{
          url: printfile_url(item)
        }]
      }.tap { |h| h.merge!(external_id: external_id(item)) if include_id }
    end

    def external_id(model)
      suffix = Rails.application.config.printful[:external_id_suffix]
      suffix ? "#{model.id}_#{suffix}" : model.id
    end

    def printful_variant(variant)
      variant.fulfiller_variants.find_by!(fulfiller: Fulfiller.printful)
    end

    def printfile_url(item)
      Rails.application.routes.url_helpers.printfile_image_url(printfile_id: printful_variant(item.variant).printfile_id, text: item.text)
    end
  end
end
