class Store < ActiveRecord::Base
  attr_accessible :description, :name, :slug, :status

  has_many :user_stores, dependent: :destroy
  has_many :users, through: :user_stores
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates_uniqueness_of :name, :slug
  validates_presence_of :name, :slug

  def add_admin admin
    user_store = UserStore.new
    user_store.store = self
    user_store.role = Role.admin
    user_store.user = admin
    user_store.save
  end

  def add_stocker stocker
    user_store = UserStore.new
    user_store.store = self
    user_store.role = Role.stocker
    user_store.user = stocker
    user_store.save
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

  def disabled?
    status == "disabled"
  end

  def approve_status
    self.status = "approved"
    save
  end

  def decline_status
    UserStore.find_by_store_id(self.id).delete
    self.delete
  end

  def disable_status
    self.status = "disabled"
    save
  end

  def enable_status
    self.status = "enabled"
    save
  end

  def approved?
    status == "approved"
  end

  def enabled?
    status == "enabled"
  end

  def disabled?
    status == "disabled"
  end
end
