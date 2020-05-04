class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.all
    
    if user_signed_in?
      @user_places = Place.where(user_id: current_user.id)
    end
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)

    respond_to do |format|
      if @place.save
        format.js
        flash[:notice] = "Spot created successfully."
      else
        format.js { render :new }
        flash.now[:alert] = @place.errors.full_messages.join(', ') if @place.errors.any?
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.js
        flash[:notice] = "Spot updated successfully."
      else
        format.js { render :edit, :locals => {:place => @place} }
        flash.now[:alert] = @place.errors.full_messages.join(', ') if @place.errors.any?
        format.json { render json: @traveller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def place_params
      params.require(:place).permit(:user_id, :secret_status, :name, :latitude, :longitude, :description, :approved, :image_one, :image_two, :image_three)
    end
end
