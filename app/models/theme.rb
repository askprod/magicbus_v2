class Theme < ApplicationRecord
    has_and_belongs_to_many :trips

    validates :name, presence: true
    validates_uniqueness_of :name

    def name=(s)
        write_attribute(:name, s.to_s.titleize) 
    end
end
