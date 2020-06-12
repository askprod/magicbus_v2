class Traveller < ApplicationRecord
    attr_accessor :phone_validation
    attr_accessor :food_participation_validation

    enum genders: [:male, :female]
    FOOD_DIETS_WITH_REDUCTION = "#{FoodDiet.find_by(name_en: "Vegan").id}"

    belongs_to :cart, optional: true
    belongs_to :order, optional: true

    has_many :diet_travellers
    has_many :food_diets, through: :diet_travellers, dependent: :destroy
    has_many :restriction_travellers
    has_many :food_restrictions, through: :restriction_travellers, dependent: :destroy

    accepts_nested_attributes_for :diet_travellers, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :restriction_travellers, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :food_diets, allow_destroy: true, reject_if: :all_blank
    accepts_nested_attributes_for :food_restrictions, allow_destroy: true, reject_if: :all_blank
  
    before_save :capitalize_attributes
    after_validation :set_food_participation

    validates :first_name, :last_name, :address, :zip_code, :birth_date, :nationality, :phone_number, :email_address, presence: :true
    validate :check_number_of_travellers_per_trip, on: :create
    validate :max_traveller_per_cart, on: :create
    validate :valid_birth_date
    validate :valid_phone_number
    validate :traveller_is_over_ten
    validates_acceptance_of :valid_passport, :allow_nil => false, :message => "has not been accepted", :on => :create
    validates_acceptance_of :sanitary_conditions, :allow_nil => false, :message => "have not been accepted", :on => :create  
    validates_acceptance_of :accompanied_minor, :allow_nil => false, :message => "have not been accepted", :on => :create, unless: :is_over_18? 
    validates_inclusion_of :gender, :in => genders
    validates_inclusion_of :insurance_status, :in => [true, false]
    validates_format_of :email_address, with: Devise.email_regexp

    def set_food_participation
      if self.food_participation_validation == FOOD_DIETS_WITH_REDUCTION
        self.update_attribute(:food_participation, false)
      end
    end
    
    def traveller_is_over_ten
      # 3650 days = 10 years
      if self.birth_date
        if Date.today.mjd - self.birth_date.mjd < 3653
          self.errors.add(:base, "We do not accept travellers who are younger that 10 years old")
        end
      end
    end

    def self.gender_attributes_for_select(hash = {})
      genders.keys.each { |key| hash[I18n.t("general_forms.gender_#{key}")] = key }
      hash
    end

    def valid_phone_number
      if self.phone_validation == "invalid"
        self.errors.add(:phone_number, "is invalid")
      end
    end

    def valid_birth_date
      if self.birth_date
        self.errors.add(:birth_date, "can't be in the future.") unless self.birth_date < DateTime.now
      end
    end

    def is_over_18?
      if self.birth_date
        birthday = self.birth_date
        age = (DateTime.now - birthday) / 365.25
        return age > 18
      else
        return true
      end
    end

    def capitalize_attributes
      self.first_name = first_name.capitalize
      self.last_name = last_name.titleize
    end
    
    def max_traveller_per_cart
      if self.cart.is_full?
        self.errors.add(:base, "You can't have more than 8 Travellers per Cart.")
      end
    end

    def check_number_of_travellers_per_trip
      self.cart.trips.each do |trip|
        if trip.is_full?
          self.errors.add(:base, " #{trip.name} has no seats left.")
        end
      end
    end
end
