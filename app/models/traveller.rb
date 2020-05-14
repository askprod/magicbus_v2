class Traveller < ApplicationRecord
    belongs_to :cart, optional: true
    belongs_to :order, optional: true

    has_many :diet_travellers
    has_many :food_diets, through: :diet_travellers, dependent: :destroy
    has_many :restriction_travellers
    has_many :food_restrictions, through: :restriction_travellers, dependent: :destroy

    accepts_nested_attributes_for :food_diets, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :food_restrictions, allow_destroy: true, reject_if: :all_blank
  
    before_save :capitalize_attributes
    after_create :set_current_age
  
    validates :first_name, :last_name, :address, :zip_code, :birth_date, :nationality, :phone_number, :email_address, presence: :true
    validates_inclusion_of :insurance_status, :in => [true, false]
    validates_format_of :email_address, with: Devise.email_regexp
    validate :check_number_of_travellers_per_trip, on: :create
    validate :max_traveller_per_cart, on: :create
    validate :valid_birth_date

    def valid_birth_date
      if self.birth_date
        self.errors.add(:birth_date, "can't be in the future.") unless self.birth_date < DateTime.now
      end
    end

    def is_over_18?
      self.age_on_create > 18
    end

    def capitalize_attributes
      self.first_name = first_name.capitalize
      self.last_name = last_name.titleize
    end

    def set_current_age
      birthday = self.birth_date
      age = (DateTime.now - birthday) / 365.25

      self.update_attribute(:age_on_create, age.to_i)
    end
    
    def max_traveller_per_cart
      if self.cart.is_full?
        self.errors.add(:base, "You can't have more than 8 Travellers per Cart.")
      end
    end

    def check_number_of_travellers_per_trip
      self.cart.trips.each do |trip|
        if trip.is_full?
          self.errors.add(:base, "Trip #{trip.name} has no seats left.")
        end
      end
    end
end
