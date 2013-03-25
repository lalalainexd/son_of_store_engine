class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image
  has_attached_file :image, styles: {
    small: '100x100>',
    medium: '200x200>',
    large: '300x300>'
  }
  has_many :product_categories
  has_many :categories, :through => :product_categories

end
