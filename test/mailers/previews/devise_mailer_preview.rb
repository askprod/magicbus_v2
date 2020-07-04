# Preview all devise emails at http://localhost:3000/rails/mailers/devise_mailer
class DeviseMailerPreview < ActionMailer::Preview
    def confirmation_instructions
      Devise::Mailer.confirmation_instructions(User.first, {})
    end
  
    def unlock_instructions
      Devise::Mailer.unlock_instructions(User.first, "faketoken")
    end
  
    def reset_password_instructions
      Devise::Mailer.reset_password_instructions(User.first, "faketoken")
    end
end