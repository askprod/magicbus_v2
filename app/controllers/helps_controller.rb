class HelpsController < ApplicationController

  def index
    @help = Help.first.help
  end

end
