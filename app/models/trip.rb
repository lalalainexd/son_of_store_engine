class Trip < ActiveRecord::Base
  attr_accessible :adults, :children, :city_of_origin, :month_of_departure, :pace
end
