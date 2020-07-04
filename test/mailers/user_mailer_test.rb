require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def send_invoice_email
    @order = Order.first
  end
end
