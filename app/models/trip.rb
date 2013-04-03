class Trip < ActiveRecord::Base
  attr_accessible :adults, :children, :city_of_origin, :month_of_departure, :pace

  CITIES = ['Independence, Missouri',
      'Kansas City, Kansas',
      'Pottawattamie County, Iowa',
      'Fort Vancouver, Canada',
      'Platte River Valley, Nebraska',
      'Julesburg, Colorado']

  PACE = %w[Steady Strenuous Grueling]

  MONTHS = %w[January February March 
              April May June July 
              August September October 
              November December]

  CHILDREN = %w[0 1 2 3 4 5 6]
  ADULTS = %w[2 3 4 5 6]

  def self.city_quantity_multipler
    { "Independence, Missouri" => 1.5,
      "Kansas City, Kansas" => 1.0,
      'Fort Vancouver, Canada' => 2.0,
      'Platte River Valley, Nebraska' => 0.8,
      'Julesburg, Colorado' => 0.5
      } 
  end

  def self.pace_quantity_multipler
    { "Steady" => 1.2,
      "Strenuous" => 1.0,
      "Grueling" => 0.8
      } 
  end

  def self.multiplier
    {
     "Independence, Missouri" => 1.5,
      "Kansas City, Kansas" => 1.0,
      'Fort Vancouver, Canada' => 2.0,
      'Platte River Valley, Nebraska' => 0.8,
      'Julesburg, Colorado' => 0.5,
      "Steady" => 2.0,
      "Strenuous" => 1.0,
      "Grueling" => 0.5
    }
  end
end
