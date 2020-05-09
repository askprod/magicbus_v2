class Traveller < ApplicationRecord
    MAX_TRAVELLERS_PER_CART = 8

    belongs_to :cart, optional: true
    belongs_to :order, optional: true

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
    validate :only_one_traveller_or_order
    validate :check_number_of_travellers_per_trip, on: :create
    validate :validate_max_traveller_per_cart, on: :create

    def capitalize_attributes
      self.first_name = first_name.capitalize
      self.last_name = last_name.titleize
    end
    
    def validate_max_traveller_per_cart
      if self.cart.travellers.count >= MAX_TRAVELLERS_PER_CART
        self.errors.add(:base, "You can't have more than 8 Travellers per Cart.")
      end
    end

    def check_number_of_travellers_per_trip
      self.cart.trips.each do |trip|
        if trip.remaining_seats_count == 0
          self.errors.add(:base, "Trip #{trip.name} has no seats left.")
        end
      end
    end

    def only_one_traveller_or_order
      if order_count + cart_count != 1 
        errors.add(:base, "Traveller can only belong to a Cart or an Order.")
      end
    end
    
    def order_count
      order.present? ? 1 : 0
    end
    
    def cart_count
      cart.present? ? 1 : 0
    end
end
