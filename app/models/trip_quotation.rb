class TripQuotation < ApplicationRecord
    belongs_to :user

    after_create :notify_slack

    def notify_slack
        SlackNotifier::QUOTATIONS.ping "🧐👋 You have received a new quotation from #{self.user.email}! Check the admin page for more info. 🧐👋"
    end
end
