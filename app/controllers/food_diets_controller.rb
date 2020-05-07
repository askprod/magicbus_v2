class FoodDietsController < ApplicationController
  before_action :set_food_diet, only: [:show, :edit, :update, :destroy]

  # GET /food_diets
  # GET /food_diets.json
  def index
    @food_diets = FoodDiet.all
  end

  # GET /food_diets/1
  # GET /food_diets/1.json
  def show
  end

  # GET /food_diets/new
  def new
    @food_diet = FoodDiet.new
  end

  # GET /food_diets/1/edit
  def edit
  end

  # POST /food_diets
  # POST /food_diets.json
  def create
    @food_diet = FoodDiet.new(food_diet_params)

    respond_to do |format|
      if @food_diet.save
        format.html { redirect_to @food_diet, notice: 'Food diet was successfully created.' }
        format.json { render :show, status: :created, location: @food_diet }
      else
        format.html { render :new }
        format.json { render json: @food_diet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_diets/1
  # PATCH/PUT /food_diets/1.json
  def update
    respond_to do |format|
      if @food_diet.update(food_diet_params)
        format.html { redirect_to @food_diet, notice: 'Food diet was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_diet }
      else
        format.html { render :edit }
        format.json { render json: @food_diet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_diets/1
  # DELETE /food_diets/1.json
  def destroy
    @food_diet.destroy
    respond_to do |format|
      format.html { redirect_to food_diets_url, notice: 'Food diet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_diet
      @food_diet = FoodDiet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_diet_params
      params.fetch(:food_diet, {})
    end
end
