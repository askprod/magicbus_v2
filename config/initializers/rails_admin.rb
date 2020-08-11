RailsAdmin.config do |config|

  config.parent_controller = '::ApplicationController'

  config.excluded_models = ["ActiveStorage::Attachment", "ActiveStorage::Blob", "ActionText::RichText", "OrderTrip", "CouponUser", "TravelTheme", "CartTrip", "DietTraveller", "RestrictionTraveller"]

  config.model 'FoodDiet' do
    navigation_label "Data"
    label "Food Diets"
  end

  config.model 'FoodRestriction' do
    navigation_label "Data"
    label "Food Allergies"
  end

  config.model 'Cart' do
    navigation_label "Cart"
    parent User

    list do
      field :user
      field :travellers
      field :trips
      field :number_of_travellers
      field :updated_at
      field :expires_at
    end
  end

  config.model 'Theme' do
    navigation_label "Data"

    list do
      sort_by :name_en
      field :name_en
      field :name_fr
      field :trips
    end
  end

  config.model 'Home' do
    navigation_label "Views"
    label "Home Page"
    label_plural "Home Page"
    weight -4

    list do
      field :description
      field :home_video
    end

    edit do
      field :home_video, :active_storage do
        delete_method :remove_video
        help "Make sure your file is .mp4 and not too large (3Mb maximum)"
      end
    end
  end

  config.model 'Help' do
    navigation_label "Views"
    label "Help FAQ"
    label_plural "Help FAQ"
    weight -4

    list do
      field :help_en
      field :help_fr
    end

    edit do 
      field :help_en
      field :help_fr
    end
  end

  config.model 'Discover' do
    navigation_label "Views"
    label "Discover Page"
    label_plural "Discover Page"
    weight -4

    list do
      field :description
      field :quote_en
      field :quote_fr
    end

    edit do
      field :quote_en
      field :quote_fr
    end
  end

  config.model 'User' do
    navigation_label "Users"
    weight -6

    object_label_method do
      :rails_admin_name
    end

    list do
      field :email
      field :created_at do
        label "Joined on"
      end
      field :rails_admin_name do
        label "Name"
      end
      field :confirmed_at do 
        label "Account Confirmed?"
        pretty_value do 
          if bindings[:object].present?
            %{<span class="label label-success">✓</span>}.html_safe
          else
            %{<span class="label label-danger">✘</span>}.html_safe
          end
        end
      end
      field :newsletter
      field :orders
    end

    show do
      field :email
      field :first_name
      field :last_name
      field :created_at
      field :confirmed_at
      field :picture
      field :cart
      field :orders
      field :coupons
      field :places do
        label "Shared Spots"
      end
    end
  end

  config.model 'Trip' do
    parent Season

    list do
      sort_by "season_id, week"
      sort_reverse :false
      field :season_id
      field :name_en do
        label "Name"
      end
      field :week
      field :price
      field :remaining_seats_count do
        label "Spots Left"
      end
      field :print_pdf do
        label "Information"
        formatted_value do
          bindings[:view].link_to('Show PDF', bindings[:view].main_app.trip_path(self.value, format: "pdf"))
        end
      end
    end

    create do 
      field :name_en
      field :name_fr
      field :description_en
      field :description_fr
      field :season
      field :week
      field :price
      field :crossed_out_price
      field :departure_date
      field :departure_location do
        partial "form_map_departure"
      end
      field :arrival_date
      field :arrival_location do
        partial "form_map_arrival"
      end
      field :picture
      field :themes
    end 

    edit do 
      field :name_en
      field :name_fr
      field :description_en
      field :description_fr
      field :season
      field :week
      field :price
      field :crossed_out_price
      field :departure_date
      field :departure_location do
        partial "form_map_departure"
      end
      field :arrival_date
      field :arrival_location do
        partial "form_map_arrival"
      end
      field :picture
      field :themes
    end 

    show do 
      field :name_en
      field :name_fr
      field :description_en
      field :description_fr
      field :season
      field :week
      field :price
      field :crossed_out_price
      field :departure_date
      field :departure_location do
        pretty_value do
          bindings[:view].render partial: 'show_map_departure', locals: {field: self}
        end
      end
      field :arrival_date
      field :arrival_location do
        pretty_value do
          bindings[:view].render partial: 'show_map_arrival', locals: {field: self}
        end
      end
      field :picture
      field :themes
    end 

  end

  config.model 'Traveller' do
    parent User

    list do
      field :created_by do
        formatted_value do
          path = bindings[:view].show_path(model_name: 'User', id: value.rails_admin_name)
          bindings[:view].link_to(value.rails_admin_name, path)
        end
      end
      field :full_name
      field :stringify_gender
      field :stringify_nationality
      field :is_booked?, :boolean
      field :is_over_18?, :boolean do
        label ">18"
      end
    end
  end

  config.model 'Order' do
    parent User

    list do 
      field :user
      field :name 
      field :trips
      field :travellers
      field :total_price
      field :payment_status
      field :created_at
      field :expires_at
      field :travellers
    end
  end

  config.model 'Place' do
    navigation_label "Maps"
    label "Shared Spots"
    weight -4

    list do
      sort_by :created_at
      field :approved_status do
        label "Approved?"
      end
      field :secret_status do 
        label "Secret?"
      end 
      field :is_a_visitor?, :boolean do
        label "Visitor?"
      end
      field :user 
      field :name
      field :description
    end

    show do 
      field :user
      field :name
      field :description
      field :approved_status
      field :secret_status
      field :location do
        pretty_value do
          bindings[:view].render partial: 'spot_info', locals: {field: self}
        end
      end
      field :image_one
      field :image_two
      field :image_three
    end
    
  end

  config.model 'Season' do
    navigation_label "Travels"
    weight -4

    list do
      sort_by :id
      field :id do
        sort_reverse :false
      end
      field :status
      field :trips
    end
  end

  config.model 'Coupon' do 
    navigation_label "PromoCodes"
    weight -3

    list do
      field :code
      field :reduction_percentage
      field :remaining_uses
      field :expiry_date
      field :minimum_trips_validity
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  # RailsAdmin.config do |config|
  #   config.authenticate_with do
  #     warden.authenticate! scope: :admin
  #   end
  #   config.current_user_method(&:current_admin)
  # end

  config.authorize_with do |controller|
    if current_user.nil?
      redirect_to main_app.root_path, flash: {alert: 'Please Log-in to continue.'}
    elsif !current_user.admin?
      redirect_to main_app.root_path, flash: {alert: "You don't have access to this page."}
    end
  end
  
  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do

    dashboard
    require_relative "#{Rails.root}/lib/rails_admin/config/actions/dashboard.rb"
          
    index                     
    new
    export
    bulk_delete
    show
    edit
    delete
    # show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
