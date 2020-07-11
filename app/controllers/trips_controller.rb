class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  after_action :delete_travellers_if_empty

  def index
    @cart_items = CartTrip.where(cart_id: @cart.id)
    @countries_list = Trip.all.pluck(:departure_location).map{|v|v['country']}.uniq.prepend("All")
    @thematics_list = Theme.all.select{|v| v.trips.count > 0 == true}.map{|v| v}

    if active_season
      @active_season = Season.where(status: true).first
      @trips = Season.find_by(status: true).trips.order(:week)
    end
  end

  def add_to_cart
    #For js render
    @ajax_trip = Trip.find(params[:trip_id]).id

    @trip = Trip.find(params[:trip_id])
    @cart_items = CartTrip.where(cart_id: @cart.id)

    begin
    @cart.trips << @trip

    respond_to do |format|
      format.js {render layout: false}
      format.html{redirect_to travel_index_path}
    end

    rescue ActiveRecord::RecordInvalid => invalid
      respond_to do |format|
        flash.now[:alert] = invalid.record.errors.full_messages.join("")
        format.js {render layout: false}
        format.html{redirect_to travel_index_path}
      end
    end
  end

  def remove_from_cart
    #For js render
    @ajax_trip = Trip.find(params[:trip_id]).id
    
    @trip = Trip.find(params[:trip_id])
    @cart_items = CartTrip.where(cart_id: @cart.id)

    @cart.trips.delete(@trip)

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
      flash.now[:notice] = "Trips sorted successfully."
      format.js
    end
  end

  def sort_trips_theme
    if params[:id] == "All"
      @sort_by_themes = Season.find_by(status: true).trips.order(:week)
    else
      theme = Theme.find_by(id: params[:id]).id
      @sort_by_themes = Trip.joins(:themes).where(themes: {id: theme}).order(:week)
    end

    respond_to do |format|
      flash.now[:notice] = "Trips sorted successfully."
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
        start_date = params[:id].split('+').first.to_date
        end_date = params[:id].split('+').last.to_date

        if start_date == 'undefined' || end_date == 'undefined'
          @sort_by_dates = Season.find_by(status: true).trips.order(:week)
        else
          trips = Season.find_by(status: true).trips.order(:week)
          
          @sort_by_dates = trips.select do |trip|
            (start_date..end_date).cover?(trip.departure_date || trip.arrival_date)
          end
        end

        respond_to do |format|
          if @sort_by_dates.empty?
            flash.now[:alert] = "No trips were found."
            format.js
          else
            flash.now[:notice] = "Trips sorted successfully."
            format.js
          end
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
