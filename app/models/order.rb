class Order < ApplicationRecord
    belongs_to :user
    belongs_to :coupon, optional: true 
    has_many :travellers, dependent: :destroy
    has_many :order_trips, dependent: :destroy
    has_many :trips, through: :order_trips

    before_save :empty_cart
    after_create :set_order_name 

    validates :travellers, presence: true
    validates :trips, presence: true

    def empty_cart
        self.user.cart.clear_cart
    end

    def set_order_name
        season = self.trips.first.season_id.to_s
        trips = self.trips.map{|t| t.week.to_s}.join("")
        travellers = self.travellers.count.to_s
        year = Time.now.year.to_s
        
        self.update_attribute(:name, "S#{season}T#{trips}V#{travellers}Y#{year}")
    end

    def total_price_calc
        if self.coupon
            self.total_price - (self.total_price * (self.coupon.reduction_percentage.to_f / 100)).round(0)
        else
            self.total_price
        end
    end
end
