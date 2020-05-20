class TravellersController < ApplicationController
  before_action :set_traveller, only: [:show, :edit, :update, :destroy]
  before_action :set_lists

  # GET /travellers
  # GET /travellers.json
  def index
    @travellers = Traveller.all
  end

  # GET /travellers/1
  # GET /travellers/1.json
  def show
  end

  # GET /travellers/new
  def new
    @traveller = Traveller.new
  end

  # GET /travellers/1/edit
  def edit
  end

  # POST /travellers
  # POST /travellers.json
  def create
    @traveller = Traveller.new(traveller_params)

    respond_to do |format|
      if @traveller.save
        format.js
        flash[:notice] = "Traveller created successfully."
      else
        format.js { render :new }
        flash.now[:alert] = @traveller.errors.full_messages.join(', ') if @traveller.errors.any?
        format.json { render json: @traveller.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /travellers/1
  # PATCH/PUT /travellers/1.json
  def update
    respond_to do |format|
      if @traveller.update(traveller_params)
        format.html { redirect_to @traveller, notice: 'Traveller was successfully updated.' }
        format.json { render :show, status: :ok, location: @traveller }
      else
        format.html { render :edit }
        format.json { render json: @traveller.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /travellers/1
  # DELETE /travellers/1.json
  def destroy
    @cart = Traveller.find(params[:id]).cart
    @traveller.destroy

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Traveller was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_lists
      @nationalities_list = JSON.parse(File.read('app/assets/json/nationalities.json'))
      @food_diets_list = FoodDiet.where(approved_status: true)
      @food_restrictions_list = FoodRestriction.where(approved_status: true)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_traveller
      @traveller = Traveller.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def traveller_params
      params.require(:traveller).permit(:gender, :insurance_status, :cart_id, :first_name, :last_name, :address, :phone_number, :zip_code, :birth_date, :nationality, :email_address, :food_restriction_ids, :food_diet_ids,  food_restrictions_attributes: [:id, :name, :_destroy], food_diets_attributes: [:id, :name, :_destroy])
    end
end
