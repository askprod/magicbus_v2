class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_one_attached :picture
  has_many :orders
  has_one :cart, dependent: :destroy
  has_many :places, dependent: :destroy
  has_many :coupon_users, dependent: :destroy
  has_many :coupons, through: :coupon_users

  validates_inclusion_of :newsletter, in: [true, false]
  validates_acceptance_of :terms_and_conditions, :allow_nil => false, :on => :create
  validate :only_one_admin
  validates :first_name, :last_name, presence: true
  validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }

  scope :admin, -> {where(admin: true)}

  before_save :capitalize_names

  def capitalize_names
    self.first_name = first_name.camelcase
    self.last_name = last_name.camelcase
  end

  def gibbon_status
    email = Digest::MD5.hexdigest(self.email)
    list_id = Rails.application.credentials[:mailchimp_list_id]
    gibbon = Gibbon::Request.new

    begin
      return true if gibbon.lists(list_id).members(email).retrieve.body[:status] == "subscribed"
    rescue Gibbon::MailChimpError => e
      return false
    end
  end

  def subscribe_to_newsletter
    email = self.email
    list_id = Rails.application.credentials[:mailchimp_list_id]
    gibbon = Gibbon::Request.new
    member_info = gibbon.lists(list_id).members(email).retrieve.body[:status]

    if self.newsletter == true && member_info != 'subscribed'
      begin
        gibbon.lists(list_id).members.create(body: {email_address: email, status: "subscribed"})
      rescue Gibbon::MailChimpError => e
      end
    end
  end
      
  def only_one_admin
    return unless admin?
  
    matches = User.admin
    if persisted?
      matches = matches.where('id != ?', id)
    end
    if matches.exists?
      raise "You can't have more than one admin."
    end
  end

  def rails_admin_name
    "#{first_name} #{last_name}"
  end
end
