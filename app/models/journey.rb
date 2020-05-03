class Journey < ApplicationRecord
    has_many :trips, dependent: :destroy

    validate :only_one_active_journey
    scope :status, -> {where(:status => true)}
  
    def only_one_active_journey
      return unless status?
      
      matches = Journey.status
      if persisted?
        matches = matches.where('id != ?', id)
      end
      
      if matches.exists?
        errors.add(:status, "You can't have more than one active journey at a time.")
      end
    end
end
