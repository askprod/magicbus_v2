class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :check_order_owner, only: [:show]

  # GET /orders
  # GET /orders.json
  def index
    @recent_orders = User.find(current_user.id).orders.where(payment_status: false)
    @paid_orders = User.find(current_user.id).orders.where(payment_status: true)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.friendly.find(params[:id])
    @vegan_id = FoodDiet.find_by(name_en: "Vegan").id
    @order_trips = @order.trips.order(:week)

    respond_to do |format|
        format.pdf do
            render pdf: "Order No. #{@order.name}",
            page_size: 'A4',
            template: "orders/show.html.erb",
            layout: "pdf.html",
            lowquality: true,
            zoom: 1,
            dpi: 72,
            margin: {top: 10, bottom: 10, left: 10, right: 10},
            footer: { center: '[page]/[topage]', font_size: 8 }
        end
    end
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

    if @order.valid?
      params[:order][:traveller_ids].each do |traveller|
        Traveller.find(traveller).update!(cart_id: nil, order_id: @order.id)
      end
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { redirect_to @cart, alert: @order.errors.full_messages.join(', ') }
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
      amount: @order.total_price_calc * 100,
      currency: 'eur',
      description: "Order N°#{@order.name}",
      payment_method_types: params['card'],
      metadata: {'order_id': "#{@order.id}"},
    )
  end

  def create_payment
    @order = Order.find(params[:order_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(params[:payment_intent_id])

    if @payment_intent.status == "succeeded"
        id = @payment_intent.id
        card_details = @payment_intent.charges.data[0]['payment_method_details']
        
        data = [
          stripe: {
            payment_intent_id: id,
          },
          customer: {
            email: params[:email],
            name: params[:name],
          },
          address: {
            city: params[:address_city],
            country: params[:address_country],
            line1: params[:address_line1],
            postal_code: params[:address_zip],
          },
          card: {
            brand: card_details.card['brand'],
            last_4: card_details.card['last4'],
            exp_year: card_details.card['exp_year'],
            exp_month: card_details.card['exp_month'],
            country: card_details.card['country'],
          }
        ]

        if @order.coupon
          @order.user.coupons << @order.coupon
        end

        @order.update!(details: data, paid_at: Time.now, expires_at: nil, payment_status: true)
        @order.save

        redirect_to order_success_payment_path(@order)
        session[:order_page] = true
        flash[:notice] = "Your Order was successful!"
    else
        flash[:alert] = "Your Order was unsuccessful. Please try again."
        redirect_to orders_path
    end
  end

  def success_payment
    @order = Order.friendly.find(params[:order_id])
    if session[:order_page].blank?
      redirect_to orders_path
    end
      session.delete(:order_page)
  end

  def promo_code
    @order = Order.find(params[:order_id])
  end

  def check_promo_code
      @order = Order.find(params[:order_id])
      @promo_code = params[:promo_code].upcase
      @coupon = Coupon.find_by(code: @promo_code)
      
      respond_to do |format|
        if @coupon && @coupon.is_usable?
          @coupon.orders << @order
          format.js
          flash[:notice] = "Your promo code has been applied."  
        else
            format.js { render :promo_code }
            flash[:alert] = "The promo code you have enterred is not valid."    
        end
      end
  end

  def destroy_promo_code
      # @cart.update!(promo_code: nil)
      # redirect_to @cart
      # flash[:notice] = "You promo code has been deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:correct_information, :total_price, traveller_ids: [], trip_ids: []).merge(user_id: current_user.id)
    end

    def check_order_owner
      unless current_user && User.find(current_user.id).orders.exists?(Order.friendly.find(params[:id]).id)
        raise "Order does not belongs to you."
      end
    end
end
