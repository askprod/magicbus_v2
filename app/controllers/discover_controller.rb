class DiscoverController < ApplicationController
  def index
    @total_users = User.all.size
    @total_trips = Trip.all.size
    # @total_travellers = Traveller.where(travelling: true).size
  end
end
