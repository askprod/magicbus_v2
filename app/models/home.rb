class Home < ApplicationRecord
    has_one_attached :home_video

    validate :only_one, on: :create

    attr_readonly :description
    attr_accessor :remove_video
    after_save { home_video.purge if remove_video.present? }
    before_destroy :keep_record

    private

    def only_one
        if Home.count > 0
            errors.add :base, "You can't have more than one video on the home page" 
        end
    end

    def keep_record
        throw :abort
    end
end
