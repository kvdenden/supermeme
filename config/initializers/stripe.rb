Rails.configuration.stripe = Rails.application.credentials.dig(Rails.env.to_sym, :stripe)

if Rails.configuration.stripe
  Stripe.api_key = Rails.configuration.stripe[:secret_key]
end
