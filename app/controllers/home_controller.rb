class HomeController < ApplicationController
  def show
#    @categories = Category.all.sort
#    @products = Category.find_by_name("Essentials").products.shuffle[0..2]
    #count = Product.count
    @products = []
    #3.times { @products << Product.find(1 + Random.rand(count)) }
    @stores = Store.order("name")
  end
end
