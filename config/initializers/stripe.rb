require "stripe"

if Rails.env == 'development'
  Rails.configuration.stripe = {
    :publishable_key => Rails.application.credentials.stripe_test[:publishable_key],
    :secret_key      => Rails.application.credentials.stripe_test[:secret_key]
  }
  Stripe.api_key = Rails.application.credentials.stripe_test[:secret_key]
else
  Rails.configuration.stripe = {
    :publishable_key => Rails.application.credentials.stripe_production[:publishable_key],
    :secret_key      => Rails.application.credentials.stripe_production[:secret_key]
  }
  Stripe.api_key = Rails.application.credentials.stripe_production[:secret_key]
end