class StoryController < ApplicationController
  require 'roo'

  def index
    @xlsx = Roo::Excelx.new("#{Rails.root}/app/assets/excel/MagicPeople.xlsx")
  end

end
