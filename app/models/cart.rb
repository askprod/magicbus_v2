class Cart < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    MAX_TRAVELLERS_PER_CART = 8
    FOOD_PARTICIPATION_PRICE = 30

    belongs_to :user
    has_many :travellers, dependent: :destroy,
        after_add: :update_expiration_time,
        after_remove: :update_expiration_time
    has_many :cart_trips
    has_many :trips, through: :cart_trips, 
        after_remove: [:check_if_cart_is_empty, :update_expiration_time],
        after_add: :update_expiration_time

    before_save :set_cart_name, on: :create
    after_create :update_slug

    validates :number_of_travellers, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 8}
    validate :can_add_a_traveller

    def can_add_a_traveller
        unless self.trips.empty?
            self.trips.each do |trip|
                if (trip.remaining_seats_count + trip.seats_available) - self.number_of_travellers <= 0
                    self.errors.add(:base, :one_trip_is_full)
                end
            end
        end
    end

    def check_if_cart_is_empty(trip)
        if self.trips.empty?
            self.clear_cart
        end
    end

    def set_cart_name
        name = "#{User.find(self.user_id).email.split('@')[0].parameterize}" + "#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
        self.name ||= name
    end

    def clear_cart
        self.update_attribute(:number_of_travellers, 1)
        self.update_attribute(:expires_at, nil)
        self.trips.delete_all

        SlackNotifier::CARTS.ping "🛒 #{self.user.email}'s cart has been emptied. 🛒"
    end

    def update_expiration_time(obj)
        self.update(expires_at: Time.now + 1.hour)
    end

    def is_full?
        if self.number_of_travellers == MAX_TRAVELLERS_PER_CART
            return true
        else
            return false
        end
    end

    def update_slug
        self.update!(slug: self.name)
    end
end
