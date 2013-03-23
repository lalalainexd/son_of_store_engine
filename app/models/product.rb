class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image
  has_attached_file :image

end
