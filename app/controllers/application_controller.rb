class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_cart
    before_action :set_locale
    before_action :set_cache_headers
  
    private
    protected

    def set_cache_headers
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    end
  
    def set_locale 
        I18n.locale = extract_locale || I18n.default_locale 
    end 

    def extract_locale 
        parsed_locale = params[:locale] 
        I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil 
    end

    def default_url_options(options = {})
        { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale  }
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :terms_and_conditions) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :picture) }
    end

    def set_cart
        if user_signed_in? && current_user.cart == nil
            # name = "#{current_user.email.split('@')[0]}-#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
            Cart.create!(user_id: current_user.id)
            @cart = Cart.find_by(user_id: current_user.id)
        elsif user_signed_in?
            @cart = Cart.find_by(user_id: current_user.id)
        else
            @cart = Cart.find(session[:cart_id]) if session[:cart_id]
            if @cart.blank?
              @cart = Cart.create(user: current_user)
              session[:cart_id] = @cart.id
            end
        end
    end

    def active_journey
        Journey.find_by(status: true).present?
    end

    def total_price(items)
        total = 0
        items.each do |item|
            total += item.price
        end
        return total
    end
end
