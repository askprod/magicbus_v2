class Order < ApplicationRecord
    belongs_to :user
    has_many :travellers, dependent: :destroy
    has_many :order_trips
    has_many :trips, through: :order_trips

    before_save :empty_cart

    validates :travellers, presence: true
    validates :trips, presence: true

    def empty_cart
        self.user.cart.clear_cart
    end
end
