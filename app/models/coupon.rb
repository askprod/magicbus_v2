class Coupon < ApplicationRecord
    validates :code, :remaining_uses, :expiry_date, :reduction_percentage, presence: :true
    validates :code, format: {with: /\A[A-Z0-9]+\z/, message: "only allows capital letters and numbers." }
    validates :reduction_percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }

    before_destroy :clear_all_codes

    def clear_all_codes
        code = self.code
        carts = Cart.where(promo_code: code)

        carts.each do |cart|
            cart.update!(promo_code: nil)
        end
    end
end
