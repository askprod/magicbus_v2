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

  config.model 'User' do
    navigation_label "Users"
    weight -6

    list do
      field :email
      field :created_at
    end
  end

  config.model 'Trip' do
    parent Season

    list do
      sort_by "season_id, week"
      sort_reverse :false
      field :season_id
      field :name
      field :week
      field :price
    end

    create do 
      field :name
      field :description_en
      field :description_fr
      field :season
      field :week
      field :price
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
      field :name
      field :description_en
      field :description_fr
      field :season
      field :week
      field :price
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
      field :name
      field :description_en
      field :description_fr
      field :season
      field :week
      field :price
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
      field :is_over_18?, :boolean do
        label ">18"
      end
    end
  end

  config.model 'Order' do
    parent User

    list do 
      field :id
      field :total_price
      field :created_at
      field :travellers
    end
  end

  config.model 'Place' do
    navigation_label "Maps"
    label "Shared Spots"
    weight -4

    list do
      sort_by :approved_status
      field :approved_status do
        label "Approved?"
        column_width 100
      end
      field :secret_status do 
        label "Secret?"
        column_width 80
      end 
      field :is_a_visitor?, :boolean do
        label "Visitor?"
      end
      field :user do
        column_width 80
      end
      field :name do
        column_width 80
      end
      field :description do
        column_width 100
      end
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
      field :remaining_uses
      field :expiry_date
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
