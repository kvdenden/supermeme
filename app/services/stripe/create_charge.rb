module Stripe
  class CreateCharge
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def call(token)
      customer = Stripe::Customer.create(
        :email => order.email,
        :source  => token
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => order.total_in_cents,
        :name        => 'Supermeme',
        :description => 'Supermeme designs',
        :currency    => 'usd'
      )
    end
  end
end
