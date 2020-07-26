class CartsController < ApplicationController
  before_action :check_cart_owner
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts/1
  # GET /carts/1.json
  def show
    @current_cart_items = @cart.trips.order(:week)
    @travellers_count = @cart.number_of_travellers
    @total_trips_price = total_price(@current_cart_items)

    @current_cart_items = @cart.trips.order(:week)

    @vegan_travellers = @cart.travellers.where(food_participation: false).count
    @food_deduction =  @vegan_travellers * Cart::FOOD_PARTICIPATION_PRICE

    @total_price = (total_price(@current_cart_items) * @travellers_count) - @food_deduction
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_traveller_quantity
    @cart = Cart.friendly.find(params[:cart_id])

    if params["button"]["increment"]
      @cart.increment(:number_of_travellers)
    elsif params["button"]["decrement"]
      @cart.decrement(:number_of_travellers)
    end

    respond_to do |format|
      if @cart.save
        format.js
      else
        format.js
        flash.now[:alert] = @cart.errors.full_messages.join
      end
    end
  end

  private

  def check_cart_owner
    @cart = current_user.cart
    unless current_user && current_user.cart == @cart
      raise "This cart does not belong to this user." 
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.fetch(:cart, {})
  end
end
