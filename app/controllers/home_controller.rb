class HomeController < ApplicationController
  def index
    if Home.first.home_video.attached?
      @video = Home.first.home_video
    end
  end
end
