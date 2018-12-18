Rails.configuration.stripe = Rails.application.credentials[:stripe]

Stripe.api_key = Rails.configuration.stripe[:secret_key]
