class Store < ActiveRecord::Base
  attr_accessible :description, :name, :slug

  has_many :user_stores
  has_many :users, :through => :user_stores

  validates_uniqueness_of :name, :slug
  validates_presence_of :name, :slug

  def approve_status
    self.status = "approved"
    save
  end

  def decline_status
    self.status = "declined"
    save
  end
end
