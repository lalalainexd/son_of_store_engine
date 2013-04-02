class ProductCategory < ActiveRecord::Base
  attr_accessible :product_id, :category_id, :products, :categories
  belongs_to :product
  belongs_to :category
end

####Fix. Make into has_and_belongs_to_many without this model
