class Store < ActiveRecord::Base
  attr_accessible :description, :name, :slug

  has_many :user_stores
  has_many :users, :through => :user_stores

  validates_uniqueness_of :name, :slug
  validates_presence_of :name, :slug

  def add_manager manager
    users << manager
    save
  end

  def to_param
    slug
  end

  def self.find(slug)
    find_by_slug(slug)
  end

  def pending?
    status == "pending"
  end
end
