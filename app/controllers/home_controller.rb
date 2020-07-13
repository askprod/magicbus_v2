class HomeController < ApplicationController
  def index
    if !Home.first.nil?
      @video = Home.first.home_video
    end
  end
end
