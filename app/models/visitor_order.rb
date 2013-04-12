class VisitorOrder < ActiveRecord::Base
  attr_accessible :visitor_id, :order_id
  belongs_to :visitor
  belongs_to :order 
end
