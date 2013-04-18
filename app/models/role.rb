class Role < ActiveRecord::Base
  attr_accessible :title
  has_many :user_stores

  def self.admin
    @admin ||= find_or_create_by_title(title: "admin")
  end

  def self.stocker
    @stocker ||= find_or_create_by_title(title: "stocker")
  end
end
