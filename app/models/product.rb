class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :image

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  has_attached_file :image, styles: {
    small: '100x100>',
    medium: '200x200>',
    large: '300x300>'
  }

  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      return true
    else
      errors.add(:base, 'Line Items present')
      return false
    end
  end

end
