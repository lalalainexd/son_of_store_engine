class Store < ActiveRecord::Base
  attr_accessible :description, :name, :slug

  has_many :user_stores
  has_many :users, :through => :user_stores

  validates_uniqueness_of :name, :slug
  validates_presence_of :name, :slug

  def add_admin admin
    # users << admin
    user_store = UserStore.new
    user_store.store = self
    user_store.role = Role.find_by_title("admin")
    user_store.user = admin
    user_store.save
    # save
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