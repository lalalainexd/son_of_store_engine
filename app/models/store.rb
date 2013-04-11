class Store < ActiveRecord::Base
  attr_accessible :description, :name, :slug

  validates_uniqueness_of :name, :slug
  validates_presence_of :name, :slug
end
