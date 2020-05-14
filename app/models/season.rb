class Season < ApplicationRecord
    has_many :trips, dependent: :destroy

    validate :only_one_active_season
    scope :status, -> {where(:status => true)}
  
    def only_one_active_season
      return unless status?
      
      matches = Season.status
      if persisted?
        matches = matches.where('id != ?', id)
      end
      
      if matches.exists?
        errors.add(:status, "You can't have more than one active Season at a time.")
      end
    end
end
