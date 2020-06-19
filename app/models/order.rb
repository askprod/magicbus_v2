class Order < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    belongs_to :user
    belongs_to :coupon, optional: true
    has_many :travellers, dependent: :destroy
    has_many :order_trips, dependent: :destroy
    has_many :trips, through: :order_trips

    before_save :empty_cart
    after_create :set_order_name 
    after_create :set_expiration_time

    validates_acceptance_of :correct_information, :allow_nil => false, :message => "have not been accepted", :on => :create
    validates :travellers, presence: true
    validates :trips, presence: true
    validate :only_one_pending_order, on: :create

    def empty_cart
        self.user.cart.clear_cart
    end

    def only_one_pending_order
        if self.user.orders.where(payment_status: false).size > 0
            errors.add(:base, "You can't have more than one pending Order at a time")
        end
    end

    def set_expiration_time
        self.update(expires_at: Time.now + 1.day)
    end

    def set_order_name
        order = sprintf('%02d', self.id)
        secure_random = SecureRandom.alphanumeric(4).upcase
        season = self.trips.first.season_id.to_s
        trips = self.trips.map{|t| t.week.to_s}.join("T")
        travellers = self.travellers.count.to_s
        year = Time.now.strftime('%y')
        
        self.update_attribute(:name, "#{order}OR#{secure_random}S#{season}T#{trips}V#{travellers}Y#{year}")
    end

    def total_price_calc
        if self.coupon
            self.total_price - (self.total_price * (self.coupon.reduction_percentage.to_f / 100)).round(0)
        else
            self.total_price
        end
    end
end
