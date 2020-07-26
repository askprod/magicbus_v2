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
    @traveller.phone_validation = (traveller_params[:phone_validation])
    @traveller.food_participation_validation = (traveller_params[:food_diet_ids])

    respond_to do |format|
      if @traveller.save
        format.js
        flash[:notice] = t("flashes.travellers.successful_create")
      else
        format.js { render :new }
        flash.now[:alert] = @traveller.errors.full_messages.join(', ') if @traveller.errors.any?
      end
    end
  end

  # PATCH/PUT /travellers/1
  # PATCH/PUT /travellers/1.json
  def update
    respond_to do |format|
      if @traveller.update(traveller_params)
        format.js { redirect_to cart_path(@cart.friendly_id), notice: t("flashes.travellers.successful_update") }
      else
        format.js { render :edit }
        flash.now[:alert] = @traveller.errors.full_messages.join(', ') if @traveller.errors.any?
      end
    end
  end

  # DELETE /travellers/1
  # DELETE /travellers/1.json
  def destroy
    @cart = Traveller.find(params[:id]).cart
    @traveller.destroy

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: t("flashes.travellers.successful_delete") }
      format.json { head :no_content }
    end
  end

  private

    def set_lists
      food_diets = FoodDiet.where(approved_status: true)
      traveller_food_diets = @cart.travellers.map{|traveller| FoodDiet.joins(:travellers).where(travellers: {id: traveller.id}).to_a }.flatten
      @food_diets_list = food_diets + traveller_food_diets
      
      food_restr = FoodRestriction.where(approved_status: true)
      traveller_food_restr = @cart.travellers.map{|traveller| FoodRestriction.joins(:travellers).where(travellers: {id: traveller.id}).to_a }.flatten
      @food_restrictions_list = food_restr + traveller_food_restr
      
      @nationalities_list = JSON.parse(File.read("app/assets/json/nationalities_#{locale}.json"))
      @genders_list = JSON.parse(File.read("app/assets/json/gender_#{locale}.json"))
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_traveller
      @traveller = Traveller.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def traveller_params
      params.require(:traveller).permit(:accompanied_minor, :additional_comment, :medical_condition, :valid_passport, :sanitary_conditions, :phone_validation, :gender, :cart_id, :first_name, :last_name, :address, :phone_number, :zip_code, :birth_date, :nationality, :email_address, restriction_travellers_attributes: [:food_restriction_id, :id, :_destroy, food_restriction_attributes: [:name_en, :id]], diet_travellers_attributes: [:food_diet_id, :id, :_destroy, food_diet_attributes: [:name_en, :id]])
    end
end
