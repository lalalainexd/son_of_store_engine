class UserStore < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  belongs_to :role
  attr_accessible :user_id, :store_id, :role_id
  delegate :name, :slug, :status, to: :store

  validates_presence_of :user, :store, :role

end
