Rails.configuration.stripe = {
    :publishable_key => ENV['PUBLISHABLE_KEY'] ||= Rails.application.credentials[Rails.env.to_sym][:stripe_publishable_key],
    :secret_key      => ENV['SECRET_KEY'] ||= Rails.application.credentials[Rails.env.to_sym][:stripe_secret_key]
 }

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = Rails.application.credentials[Rails.env.to_sym][:stripe_signing_key]

StripeEvent.configure do |events|
    events.subscribe 'payment_intent.', Stripe::EventHandler.new
end
