class FoodRestrictionsController < ApplicationController
  before_action :set_food_restriction, only: [:show, :edit, :update, :destroy]

  # GET /food_restrictions
  # GET /food_restrictions.json
  def index
    @food_restrictions = FoodRestriction.all
  end

  # GET /food_restrictions/1
  # GET /food_restrictions/1.json
  def show
  end

  # GET /food_restrictions/new
  def new
    @food_restriction = FoodRestriction.new
  end

  # GET /food_restrictions/1/edit
  def edit
  end

  # POST /food_restrictions
  # POST /food_restrictions.json
  def create
    @food_restriction = FoodRestriction.new(food_restriction_params)

    respond_to do |format|
      if @food_restriction.save
        format.html { redirect_to @food_restriction, notice: 'Food restriction was successfully created.' }
        format.json { render :show, status: :created, location: @food_restriction }
      else
        format.html { render :new }
        format.json { render json: @food_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /food_restrictions/1
  # PATCH/PUT /food_restrictions/1.json
  def update
    respond_to do |format|
      if @food_restriction.update(food_restriction_params)
        format.html { redirect_to @food_restriction, notice: 'Food restriction was successfully updated.' }
        format.json { render :show, status: :ok, location: @food_restriction }
      else
        format.html { render :edit }
        format.json { render json: @food_restriction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /food_restrictions/1
  # DELETE /food_restrictions/1.json
  def destroy
    @food_restriction.destroy
    respond_to do |format|
      format.html { redirect_to food_restrictions_url, notice: 'Food restriction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food_restriction
      @food_restriction = FoodRestriction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_restriction_params
      params.fetch(:food_restriction, {})
    end
end
