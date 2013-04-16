class Role < ActiveRecord::Base
  attr_accessible :title
  has_many :user_stores

  def self.admin
    @admin ||= Role.find_by_title("admin")
  end
end
