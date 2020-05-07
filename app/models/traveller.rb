class Traveller < ApplicationRecord
    belongs_to :cart

    has_many :diet_travellers
    has_many :food_diets, through: :diet_travellers, dependent: :destroy
    has_many :restriction_travellers
    has_many :food_restrictions, through: :restriction_travellers, dependent: :destroy

    accepts_nested_attributes_for :food_diets, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :food_restrictions, allow_destroy: true, reject_if: :all_blank
  
    # before_create :validate_traveller_limit
    before_save :capitalize_attributes
  
    validates :first_name, :last_name, :address, :zip_code, :birth_date, :nationality, :phone_number, :email_address, presence: :true
    validates_inclusion_of :insurance_status, :in => [true, false]
    validates_format_of :email_address, with: Devise.email_regexp

    def capitalize_attributes
      self.first_name = first_name.capitalize
      self.last_name = last_name.titleize
    end
end
