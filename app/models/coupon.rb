class Coupon < ApplicationRecord
    has_many :orders

    validates :code, :remaining_uses, :expiry_date, :reduction_percentage, presence: :true
    validates :code, format: {with: /\A[A-Z0-9]+\z/, message: "only allows capital letters and numbers." }
    validates :reduction_percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

    def remaining_uses_left
        used = self.orders.count
        limit = self.remaining_uses
        return limit - used
    end

    def is_usable?
        [self.remaining_uses_left != 0, self.expiry_date > Date.today].all?
    end
end
