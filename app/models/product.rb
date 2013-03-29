class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image, :category_ids

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  # has_attached_file :image, styles: {
  #   small: '100x100>',
  #   medium: '200x200>',
  #   large: '300x300>',
  #   x_large: '400x400>',
  #   xx_large: '500x500>',
  #   xxx_large: '600x600>'
  # }


  has_attached_file :image, styles: {
    small: '100x100>',
    medium: '200x200>',
    large: '300x300>',
    x_large: '400x400>',
    xx_large: '500x500>',
    xxx_large: '600x600>'
    },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'oregon-sale'

  
  has_many :product_categories
  has_many :categories, :through => :product_categories

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
