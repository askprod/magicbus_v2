class Traveller < ApplicationRecord
    belongs_to :cart
    belongs_to :food_diet, optional: true
    belongs_to :food_restriction, optional: true
  
    before_create :validate_traveller_limit
    before_save :capitalize_attributes
  
    validates :first_name, :last_name, :address, :zip_code, :birth_date, :nationality, :phone_number, :email, presence: :true
    validates_inclusion_of :insurance, :in => [true, false]
    validates_format_of :email, with: Devise.email_regexp

    def capitalize_attributes
      self.first_name = first_name.capitalize
      self.last_name = last_name.titleize
    end
end
