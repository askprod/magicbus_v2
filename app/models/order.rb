class Order < ApplicationRecord
    belongs_to :user
    belongs_to :coupon, optional: true 
    has_many :travellers, dependent: :destroy
    has_many :order_trips, dependent: :destroy
    has_many :trips, through: :order_trips

    before_save :empty_cart

    validates :travellers, presence: true
    validates :trips, presence: true

    def empty_cart
        self.user.cart.clear_cart
    end

    def total_price_calc
        if self.coupon
            self.total_price - (self.total_price * (self.coupon.reduction_percentage.to_f / 100)).round(0)
        else
            self.total_price
        end
    end
end
