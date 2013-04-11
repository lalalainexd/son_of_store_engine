class UserStore < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  # attr_accessible :title, :body
end
