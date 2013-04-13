class Visitor < ActiveRecord::Base
  attr_accessible :email

  has_many :visitor_orders
  has_many :orders, through: :visitor_orders

  validates_presence_of :email

  def to_s
    email
  end
end
