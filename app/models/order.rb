class Order < ApplicationRecord
    belongs_to :user
    has_many :trip_travellers
    has_many :trips, through: :trip_travellers, dependent: :destroy
    has_many :travellers, through: :trip_travellers, dependent: :destroy
end
