Recaptcha.configure do |config|
    config.site_key  = Rails.application.credentials[:recaptcha_public_key]
    config.secret_key = Rails.application.credentials[:recaptcha_private_key]
end