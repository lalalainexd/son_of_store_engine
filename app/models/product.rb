class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image, :category_ids, :retired

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item
  scope :active, where(:retired => false)
  scope :retired, where(:retired => true)

  if Rails.env.production?
    has_attached_file :image,
      :styles => {
        small: '100x100>',
        medium: '200x200>',
        large: '300x300>',
        x_large: '400x400>',
        xx_large: '500x500>',
        xxx_large: '600x600>'
      },
      :storage => :s3,
      :bucket => "oregon-sale",
      :path => ":attachment/:id/:style.:extension",
      :s3_credentials => {
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
      }
  else
    has_attached_file :image,
      :styles => {
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
  end

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
