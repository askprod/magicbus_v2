class Cart < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    belongs_to :user
    has_many :travellers, dependent: :destroy
    has_many :cart_trips
    has_many :trips, :through => :cart_trips

    before_save :set_cart_name, on: :create

    def set_cart_name
        name = "#{User.find(self.user_id).email.split('@')[0]}-#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
        self.name ||= name
    end
end
