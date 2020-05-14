class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  after_action :delete_travellers_if_empty

  def index
    @cart_items = CartTrip.where(cart_id: @cart.id)
    @countries_list = Trip.all.pluck(:departure_location).map{|v|v['country']}.uniq.prepend("All")
    @thematics_list = Theme.all.select{|v| v.trips.count > 0 == true}.map{|v| v.name}.prepend("All")
    
    if active_season
      @trips = Season.find_by(status: true).trips.order(:week)
    end
  end

  def add_to_cart
    #For js render
    @ajax_trip = Trip.find(params[:trip_id]).id

    @trip = Trip.find(params[:trip_id])
    @cart_items = CartTrip.where(cart_id: @cart.id)

    new_cart_item = CartTrip.create!(cart_id: @cart.id, trip_id:(params[:trip_id]))
    new_cart_item.save

    respond_to do |format|
      format.js {render layout: false}
      format.html{redirect_to travel_index_path}
    end
  end

  def remove_from_cart
    #For js render
    @ajax_trip = Trip.find(params[:trip_id]).id
    
    @trip = Trip.find(params[:trip_id])
    @trips = Season.find_by(status: true).trips.order(:week)
    @cart_items = CartTrip.where(cart_id: @cart.id)

    find_cart_item = CartTrip.where(cart_id: @cart.id, trip_id: (params[:trip_id]))
    find_cart_item.delete_all

    if params[:response_type] == "html"
      respond_to do |format|
          format.html{redirect_to cart_path(@cart)}
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def sort_trips_country
    if params[:id] == "All"
      @sort_by_countries = Season.find_by(status: true).trips.order(:week)
    else
      country = params[:id]
      @sort_by_countries = Trip.where("departure_location->>'country' = ?", "#{country}").order(:week)
    end

    respond_to do |format|
      format.js
    end
  end

  def sort_trips_theme
    if params[:id] == "All"
      @sort_by_themes = Season.find_by(status: true).trips.order(:week)
    else
      theme = Theme.find_by(name: params[:id]).id
      @sort_by_themes = Trip.joins(:themes).where(themes: {id: theme})
    end

    respond_to do |format|
      format.js
    end
  end

  def sort_trips_date
      if params[:id] == "reset"
        @sort_by_dates = Season.find_by(status: true).trips.order(:week)

        respond_to do |format|
          format.js { render "sort_trips_reset.js.erb" }
        end
      else
        start_date = params[:id].split('+').first
        end_date = params[:id].split('+').last

        if start_date == 'undefined' || end_date == 'undefined'
          @sort_by_dates = Season.find_by(status: true).trips.order(:week)
        else
          @sort_by_dates = Trip.where("departure_date::date >= '#{start_date}' ").where("arrival_date::date <= '#{end_date}' ")
        end

        respond_to do |format|
            format.js
          end
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_params
      params.fetch(:trip, {})
    end
    
    def delete_travellers_if_empty
      if @cart.trips.empty?
        @cart.travellers.destroy_all
      end
  end
end
