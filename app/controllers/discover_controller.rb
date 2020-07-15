class DiscoverController < ApplicationController
  def index
    @total_users = User.all.size
    @total_trips = Trip.all.size
    @total_travellers = Traveller.all.size

    unless Discover.first.quote_fr.blank? || Discover.first.quote_en.blank?
      @quote = Discover.first.quote
    end
  end
end
