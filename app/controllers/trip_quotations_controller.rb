class TripQuotationsController < ApplicationController
  def new
    @trip_quotation = TripQuotation.new
    @numbers_select = [1, 2, 3, 4, 5, 6, 7, 8]
    @quotation_format = ["Week-end", "Full week", "Other"]

    if params[:trip]
      @trip = PrivateTrip.find(params[:trip])
    end 
  end

  def create
    @trip_quotation = current_user.trip_quotations.new(trip_quotation_params)

    respond_to do |format|
      if @trip_quotation.save!
        format.js
        flash[:notice] = "Quotation successfully sent. We will reply as soon as we can!"
      else
        format.js { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip_quotation
      @trip_quotation = TripQuotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trip_quotation_params
      params.require(:trip_quotation).permit(:message, :user_id, :selected_trip, :first_name, :last_name, :email, :departure_date, :phone_number)
    end
end
