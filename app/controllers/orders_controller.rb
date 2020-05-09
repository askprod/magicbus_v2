class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @user_orders = User.find(1).orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save

        params[:order][:traveller_ids].each do |traveller|
          Traveller.find(traveller).update!(cart_id: nil, order_id: @order.id)
        end

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_payment
    @order = Order.find(params[:order_id])
    
    @payment_intent = Stripe::PaymentIntent.create(
      amount: @order.total_price * 100,
      currency: 'eur',
      payment_method_types: params['card'],
      metadata: {integration_check: 'accept_a_payment'},
  )
  end

  def create_payment
    @order = Order.find(params[:order_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(params[:payment_intent_id])

    if @payment_intent.status == "succeeded"
        charge = @payment_intent.charges.data.first
        card = charge.payment_method_details.card

        @order.update!(payment_status: true)
        @order.save

        flash[:alert] = "Your Order has been purchased."
        redirect_to orders_path
    else
        flash[:alert] = "Your Order was unsuccessful. Please try again."
        redirect_to root_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:total_price, :traveller_ids, :trip_ids).merge(user_id: current_user.id)
    end
end
