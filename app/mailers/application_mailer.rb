class ApplicationMailer < ActionMailer::Base
  default from: 'MagicBus <hello@magicbusworld.com>'
  default reply_to: 'MagicBus <hello@magicbusworld.com>'
  # layout is in views/layouts/mailer.html.erb
  layout 'mailer'
end
