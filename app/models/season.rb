class Season < ApplicationRecord
    has_many :trips, dependent: :destroy
    has_rich_text :description_fr
    has_rich_text :description_en

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

    def description
      self.send("description_#{I18n.locale}")
    end
end
