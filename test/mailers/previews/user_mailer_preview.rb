# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
    def send_invoice_email
        order = Order.where.not(paid_at: nil).first
        UserMailer.send_invoice_email(order)
    end
end
