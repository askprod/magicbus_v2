class DiscoverController < ApplicationController
  def index
    @total_users = User.all.size
    @total_trips = Trip.all.size
    @total_travellers = Traveller.all.size
  end
end
