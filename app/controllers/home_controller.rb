class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
    @products = Category.find_by_name("Essentials").products.shuffle[0..2]
  end
end
