class Discover < ApplicationRecord
    has_rich_text :quote_en
    has_rich_text :quote_fr

    validate :only_one, on: :create

    attr_readonly :description
    before_destroy :keep_record

    def quote
        self.send("quote_#{I18n.locale}")
    end
    
    private

    def only_one
        if Discover.count > 0
            errors.add :base, "You can't have more than one quote on the discover page" 
        end
    end

    def keep_record
        throw :abort
    end
end
