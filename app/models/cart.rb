class Cart < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    belongs_to :user
    has_many :travellers
    # has_many :cart_trips
    # has_many :trips, :through => :cart_trips

    validates :name, presence: true

    before_save :set_cart_name

    def set_cart_name
        mail = self.email_address.slice(0..(str.index('@')))
        self.name ||= "#{mail}-#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}#{rand(1..9)}"
    end
end
