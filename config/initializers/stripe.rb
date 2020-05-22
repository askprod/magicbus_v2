Rails.configuration.stripe = {
    :publishable_key => ENV['PUBLISHABLE_KEY'] ||= Rails.application.credentials[Rails.env.to_sym][:stripe_publishable_key],
    :secret_key      => ENV['SECRET_KEY'] ||= Rails.application.credentials[Rails.env.to_sym][:stripe_secret_key]
 }

Stripe.api_key = Rails.configuration.stripe[:secret_key]
