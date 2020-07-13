class Home < ApplicationRecord
    has_one_attached :home_video

    validate :only_one, on: :create

    private

    def only_one
        if Home.count >= 1
            errors.add :base, "You can't have more than one video on the home page" 
        end
    end
end
