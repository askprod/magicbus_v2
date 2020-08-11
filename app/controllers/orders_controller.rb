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
    @order = Order.new(order_params)
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.create(order_params)

    if @order.valid?
      params[:order][:traveller_ids].each do |traveller|
        Traveller.find(traveller).update!(cart_id: nil, order_id: @order.id)
      end
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: t("flashes.orders.successful_create") }
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
        format.html { redirect_to @order, notice: t("flashes.orders.successful_update") }
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
      format.html { redirect_to orders_url, notice: t("flashes.orders.successful_delete") }
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

    @order.update!(details: event, paid_at: Time.now, expires_at: nil, payment_status: true)
    @order.save

    respond_to do |format|
      if @order.save

        UserMailer.send_invoice_email(@order).deliver_later
        SlackNotifier::ORDERS.ping "💰🥳 Order #{@order.name}, from user #{@order.user.email} has just been paid, for a total of #{@order.total_price}€. 🥳💰"
        
        @order.travellers.each do |traveller|
          UserMailer.send_traveller_booked_email(@order, traveller).deliver_later
        end

        session[:order_page] = true
        flash[:notice] = t("flashes.orders.successful_payment")
        format.html { redirect_to order_success_payment_path(@order) }
      else
        flash[:alert] = t("flashes.orders.could_not_process")
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
        @coupon.current_order = @order
        respond_to do |format|
          if @coupon.save
            @coupon.orders << @order
            format.js
            flash[:notice] = t("flashes.orders.code_applied")
          else
            format.js { render :promo_code }
            flash.now[:alert] = @coupon.errors.full_messages.join(", ")
          end
        end
      else
        respond_to do |format|
          format.js { render :promo_code }
          flash.now[:alert] = t("flashes.orders.invalid_code")
        end
      end

  end

  def destroy_promo_code
    @order = Order.find(params[:order_id])
    @order.update(coupon: nil)
    
    respond_to do |format|
      format.html {redirect_to orders_path}
      flash[:notice] = t("flashes.orders.code_removed")
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
      params.require(:order).permit(:correct_information, traveller_ids: [], trip_ids: []).merge(user_id: current_user.id)
    end

    def check_order_owner
      unless current_user && User.find(current_user.id).orders.exists?(Order.friendly.find(params[:id]).id)
        raise "Order does not belongs to you."
      end
    end
end
