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

  validates_acceptance_of :terms_and_conditions, :allow_nil => false, :on => :create
  validate :only_one_admin
  validates :first_name, :last_name, presence: true
  validates :picture, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 0..1.megabytes }

  scope :admin, -> {where(admin: true)}

  before_save :capitalize_names
  # after_create :send_welcome_mail
  # after_create :add_to_mailing_list

  def capitalize_names
    self.first_name = first_name.camelcase
    self.last_name = last_name.camelcase
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

  # def send_welcome_mail
  #   UserMailer.welcome_email(self.email).deliver!
  #   puts "**" * 1000
  #   puts self.email
  #   puts "Sent email"
  # end

  # def add_to_mailing_list
  # end
end
