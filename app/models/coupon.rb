class Coupon < ApplicationRecord
    attr_accessor :current_order_user
    belongs_to :order, optional: :true
    has_many :coupon_users
    has_many :users, through: :coupon_users

    validates :code, :remaining_uses, :expiry_date, :reduction_percentage, presence: :true
    validates :code, format: {with: /\A[A-Z0-9]+\z/, message: "only allows capital letters and numbers." }
    validates :reduction_percentage, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
    validate :is_usable
    validate :user_already_used

    def remaining_uses_left
        used = self.users.count
        limit = self.remaining_uses
        return limit - used
    end

    def user_already_used
        if current_order_user
            if self.users.where(id: current_order_user.id).exists?
                self.errors.add(:base, "You have already used this code.")
            end
        end
    end

    def is_usable
        unless [self.remaining_uses_left != 0, self.expiry_date > Date.today].all?
            self.errors.add(:base, "This code is not valid.")
        end
    end
end
