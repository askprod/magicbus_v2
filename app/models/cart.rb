class Cart < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    MAX_TRAVELLERS_PER_CART = 8

    belongs_to :user
    has_many :travellers, dependent: :destroy
    has_many :cart_trips
    has_many :trips, through: :cart_trips

    before_save :set_cart_name, on: :create
    after_create :update_slug

    def set_cart_name
        name = "#{User.find(self.user_id).email.split('@')[0]}-#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
        self.name ||= name
    end

    def clear_cart
        self.trips.delete_all
    end

    def is_full?
        return true if self.travellers.count == MAX_TRAVELLERS_PER_CART
    end

    def update_slug
        self.update!(slug: self.name)
    end
end
