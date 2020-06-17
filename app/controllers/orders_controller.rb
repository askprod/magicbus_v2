class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :check_order_owner, only: [:show]

  # GET /orders
  # GET /orders.json
  def index
    @recent_order = User.find(current_user.id).orders.where(payment_status: false).first
    @paid_orders = User.find(current_user.id).orders.where(payment_status: true)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.friendly.find(params[:id])
    @order_trips = @order.trips.order(:week)

    respond_to do |format|
        format.pdf do
            render pdf: "Order No. #{@order.name}",
            page_size: 'A4',
            template: "orders/invoice_pdf.#{I18n.locale}.html.erb",
            layout: "invoice_pdf_layout.html",
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
    event = Stripe::PaymentIntent.retrieve(params[:payment_intent_id])

    if @order.coupon
        @order.user.coupons << @order.coupon
    end

    @order.update!(coupon: nil, details: event, paid_at: Time.now, expires_at: nil, payment_status: true)
    @order.save

    respond_to do |format|
      if @order.save
        session[:order_page] = true
        flash[:notice] = "Your payment was successful!"
        format.html { redirect_to order_success_payment_path(@order) }
      else
        flash[:alert] = "We could not process your order. Please contact us."
        redirect_to orders_path
        format.html { redirect_to orders_path }
      end
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

      unless @coupon.nil? 
        @coupon.current_order_user = @order.user
        respond_to do |format|
          if @coupon.save
            @order.coupon = @coupon
            format.js
            flash[:notice] = "Your promo code has been applied."  
          else
            format.js { render :promo_code }
            flash.now[:alert] = @coupon.errors.full_messages.join(", ")
          end
        end
      else
        respond_to do |format|
          format.js { render :promo_code }
          flash.now[:alert] = "This code is invalid."
        end
      end

  end

  def destroy_promo_code
    @order = Order.find(params[:order_id])
    @order.update(coupon: nil)
    
    respond_to do |format|
      format.html {redirect_to orders_path}
      flash[:notice] = "Promo code removed successfully."
    end
  end

  def update_rgpd_validation
    @order = Order.friendly.find(params[:order_id])

    puts params[:value]
    if params[:value] == "true"
      @order.update_attribute(:rgpd_validated, true)
    elsif params[:value] == "false"
      @order.update_attribute(:rgpd_validated, false)
    end
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
