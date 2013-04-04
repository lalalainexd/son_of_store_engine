class Trip < ActiveRecord::Base
  attr_accessible :adults, :children, :city_of_origin,
                  :month_of_departure, :pace

  private
  CITIES = ['St. Louis, Missouri',
      'Independence, Missouri',
      'Pottawattamie County, Iowa',
      'York Factory, Canada',
      'Platte River Valley, Nebraska',
      'Julesburg, Colorado']

  PACE = %w[Steady Strenuous Grueling]

  MONTHS = %w[January February March
              April May June July
              August September October
              November December]

  CHILDREN = %w[0 1 2 3 4 5 6]
  ADULTS = %w[2 3 4 5 6]

  def self.multiplier
    {
     "Independence, Missouri" => 1.0,
      "St. Louis, Missouri" => 1.0,
      'Pottawattamie County, Iowa' => 1.0,
      'York Factory, Canada' => 2.0,
      'Platte River Valley, Nebraska' => 0.8,
      'Julesburg, Colorado' => 0.5,
      "Steady" => 2.0,
      "Strenuous" => 1.0,
      "Grueling" => 0.5
    }
  end

  def self.basics(trip)
    {Product.find_by_name("Oxen") =>
      (4 * multiplier[trip.city_of_origin]).to_i,
    Product.find_by_name("Guide") =>
      (1 * multiplier[trip.city_of_origin]).to_i,
    Product.find_by_name("Tombstone") =>
      (1 * multiplier[trip.city_of_origin]).to_i,
    Product.find_by_name("Wagon") =>
      (0.25 * (trip.children+trip.adults)).to_i}
  end

  def self.foods(trip)
    {Product.find_by_name("Rations") =>
        (20 * multiplier[trip.city_of_origin] *
          multiplier[trip.pace] *
          (trip.children+trip.adults)).to_i,
      Product.find_by_name("Bacon") =>
        (5 * multiplier[trip.city_of_origin] *
          multiplier[trip.pace] *
          (trip.children+trip.adults)).to_i,
      Product.find_by_name("Sarsaparilla") =>
        (5 * multiplier[trip.city_of_origin] *
          multiplier[trip.pace] *
          (trip.children+trip.adults)).to_i,
      Product.find_by_name("Apples") =>
        (5 * multiplier[trip.city_of_origin] *
          multiplier[trip.pace] *
          (trip.children+trip.adults)).to_i}
  end

  def self.tools(trip)
    {Product.find_by_name("Sleeping Bag") =>
        (trip.children+trip.adults).to_i,
      Product.find_by_name("Carpenter's Tools") =>
        ((trip.children+trip.adults)/2).to_i,
      Product.find_by_name("Medicine bag") =>
        ((trip.children+trip.adults)/2).to_i,
      Product.find_by_name("Stone Hunting Knife") =>
        (trip.adults).to_i}
  end

  def self.image
    {'St. Louis, Missouri' => 'stlou.png',
      'Independence, Missouri' => 'inde.png',
      'Pottawattamie County, Iowa' => 'iowa.png',
      'York Factory, Canada' => 'cana.png',
      'Platte River Valley, Nebraska' => 'nebr.png',
      'Julesburg, Colorado' => 'colo.png'
    }
  end

end
