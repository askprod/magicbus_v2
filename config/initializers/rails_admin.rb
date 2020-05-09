RailsAdmin.config do |config|

  config.excluded_models = ["TravelTheme", "CartTrip", "DietTraveller", "RestrictionTraveller"]

  config.model 'FoodDiet' do
    navigation_label "Data"
    label "Food Diets"
  end

  config.model 'FoodRestriction' do
    navigation_label "Data"
    label "Food Restrictions"
  end

  config.model 'Cart' do
    navigation_label "Cart"
    parent User
  end

  config.model 'Theme' do
    navigation_label "Data"

    list do
      sort_by :name
      field :name
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

  config.model 'ActiveStorage::Blob' do
    navigation_label "Uploads"
    weight -1

    list do
      sort_by :id
      field :filename
      field :byte_size
      field :content_type
    end
  end

  config.model 'ActiveStorage::Attachment' do
    navigation_label "Uploads"

    list do
      sort_by :id
      field :id
      field :record
      field :blob
    end
  end

  config.model 'Trip' do
    parent Journey

    list do
      sort_by "journey_id, week"
      sort_reverse :false
      field :journey_id
      field :name
      field :week
      field :price
    end

    create do 
      field :name
      field :description
      field :journey
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
      field :meetup_time
      field :picture
      field :themes
    end 
    
    configure :description, :text do
      html_attributes do
        {:maxlength => 200}
      end
    end

    configure :themes do
      help 'At least one required. !! NO ERROR MESSAGES !!'
    end

    configure :departure_country do
      partial "specific_country"
    end
    
    configure :departure_city do
      partial "specific_city"
    end

  end

  config.model 'Traveller' do
    parent User
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
      field :approved_status
      field :user
      field :secret_status
      field :name
      field :description
    end
  end

  config.model 'Journey' do
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
