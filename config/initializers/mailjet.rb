Mailjet.configure do |config|
    config.api_key = Rails.application.credentials[:mailjet_public_key]
    config.secret_key = Rails.application.credentials[:mailjet_private_key]
    config.default_from = Rails.application.credentials[:mailjet_default_from]
end