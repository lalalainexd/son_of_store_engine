class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :orders

  attr_accessible :full_name, :display_name, :email, :password,
                  :password_confirmation, :role, :stripe_customer_token

  validates_presence_of :full_name, on: :create
  validates_confirmation_of :password
  validates_presence_of :password, on: :create
  validates_presence_of :email
  validates_uniqueness_of :email

  ROLES = %w[superuser admin user]

  def role?(role)
    self.role == role.to_s
  end
end
