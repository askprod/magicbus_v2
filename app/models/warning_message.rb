class WarningMessage < ApplicationRecord
    has_rich_text :title_fr
    has_rich_text :title_en
    has_rich_text :content_fr
    has_rich_text :content_en

    validate :only_one, on: :create

    attr_readonly :description
    before_destroy :keep_record

    def title
        self.send("title_#{I18n.locale}")
    end

    def content
        self.send("content_#{I18n.locale}")
    end

    private

    def only_one
        if WarningMessage.count > 0
            errors.add :base, "You can't have more than one warning message." 
        end
    end

    def keep_record
        throw :abort
    end
end
