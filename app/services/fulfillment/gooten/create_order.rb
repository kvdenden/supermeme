# frozen_string_literal: true

module Fulfillment
  module Gooten
    class CreateOrder
      attr_reader :order

      def initialize(order)
        @order = order
      end

      def call(confirm: false)
        response = RestClient.post(request_uri, purchase_order_payload(confirm).to_json, content_type: :json)
        body = JSON.parse(response.body)
        body["Id"]
      end

      def fulfiller
        Fulfiller.gooten
      end

      private

      def request_uri
        recipe_id = Rails.configuration.gooten[:recipe_id]
        "https://api.print.io/api/v/5/source/api/orders/?recipeid=#{recipe_id}"
      end

      def purchase_order_payload(confirm)
        {
          IsInTestMode: !confirm,
          ShipToAddress: {
            FirstName: order.first_name,
            LastName: order.last_name,
            Line1: order.address.street1,
            Line2: order.address.street2,
            City: order.address.city,
            State: order.address.state_code,
            CountryCode: order.address.country_code,
            PostalCode: order.address.zip_code,
            Email: order.email,
            Phone: "0123456789"
          },
          BillingAddress: {
            FirstName: order.first_name,
            LastName: order.last_name,
            Line1: order.address.street1,
            Line2: order.address.street2,
            City: order.address.city,
            State: order.address.state_code,
            CountryCode: order.address.country_code,
            PostalCode: order.address.zip_code,
            Email: order.email,
          },
          Items: order.line_items.map { |item| line_item_payload(item) },
          Payment: {
            PartnerBillingKey: Rails.configuration.gooten[:partner_billing_key]
          },
          SourceId: external_id(order),
          IsPartnerSourceIdUnique: true
        }
      end

      def line_item_payload(item)
        {
          SKU: gooten_variant(item.variant).sku,
          ShipType: "standard",
          Quantity: item.quantity,
          Images: [
            {
              Url: printfile_url(item)
            }
          ],
          SourceId: external_id(item)
        }
      end

      def external_id(model)
        suffix = Rails.application.config.fulfillment[:external_id_suffix]
        suffix ? "#{model.id}_#{suffix}" : model.id
      end

      def gooten_variant(variant)
        variant.fulfiller_variants.find_by!(fulfiller: fulfiller)
      end

      def printfile_url(item)
        Rails.application.routes.url_helpers.printfile_image_url(printfile_id: gooten_variant(item.variant).printfile_id, text: item.text)
      end
    end
  end
end
