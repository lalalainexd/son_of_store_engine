class HomeController < ApplicationController
  def show
    @categories = Category.all.sort
  end
end
