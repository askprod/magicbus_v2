class Help < ApplicationRecord
    has_rich_text :help_fr
    has_rich_text :help_en

    before_destroy :keep_record
    validate :only_one, on: :create

    def help
        self.send("help_#{I18n.locale}")
    end

    def only_one
        if Help.count > 0
            errors.add :base, "You can't have more than one quote on the discover page" 
        end
    end

    def keep_record
        throw :abort
    end
end
