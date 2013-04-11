class Role < ActiveRecord::Base
  attr_accessible :title
  has_many :user_stores
end
