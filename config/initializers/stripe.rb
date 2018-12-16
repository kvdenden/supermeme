Rails.configuration.stripe = Rails.application.credentials[Rails.env.to_sym][:stripe]

Stripe.api_key = Rails.configuration.stripe[:secret_key]
