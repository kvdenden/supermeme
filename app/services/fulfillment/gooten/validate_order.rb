# frozen_string_literal: true

module Fulfillment
  module Gooten
    class ValidateOrder
      attr_reader :order

      def initialize(order)
        @order = order
      end

      def call
        response = RestClient.get(request_uri)
        response.code == 200 && JSON.parse(response.body)["IsValid"]
      end

      private

      def request_uri
        address = order.address
        return false if address.nil?

        query = {
          recipeid: Rails.configuration.gooten[:recipe_id],
          line1: address.street1,
          line2: address.street2,
          city: address.city,
          state: address.state_code,
          postalCode: address.zip_code,
          countryCode: address.country_code
        }.to_query

        "https://api.print.io/api/v/5/source/api/addressvalidation/?#{query}"
      end
    end
  end
end
