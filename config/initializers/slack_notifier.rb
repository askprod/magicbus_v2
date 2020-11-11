module SlackNotifier
    USERS = Slack::Notifier.new Rails.application.credentials.slack[:users_token]
    ORDERS = Slack::Notifier.new Rails.application.credentials.slack[:orders_token]
    SPOTS = Slack::Notifier.new Rails.application.credentials.slack[:spots_token]
    CARTS = Slack::Notifier.new Rails.application.credentials.slack[:carts_token]
    QUOTATIONS = Slack::Notifier.new Rails.application.credentials.slack[:quotations_token]
end