class UserStore < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  belongs_to :role
  # attr_accessible :title, :body
  delegate :name, :slug, :status, to: :store
end
