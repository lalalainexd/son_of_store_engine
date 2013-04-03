class TripsController < ApplicationController
  def index
    @trips = Trip.all

    render :index
  end

  def show
    @trip = Trip.find(params[:id])
    @basics = {
      Product.find_by_name("Oxen") =>
        (4 * Trip.multiplier[@trip.city_of_origin]).to_i,
      Product.find_by_name("Guide") =>
        (1 * Trip.multiplier[@trip.city_of_origin]).to_i,
      Product.find_by_name("Tombstone") =>
        (1 * Trip.multiplier[@trip.city_of_origin]).to_i,
      Product.find_by_name("Wagon") =>
        (0.25 * (@trip.children+@trip.adults)).to_i}
    @foods = {
      Product.find_by_name("Rations") =>
        (20 * Trip.multiplier[@trip.city_of_origin] *
          Trip.multiplier[@trip.pace] *
          (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Bacon") =>
        (5 * Trip.multiplier[@trip.city_of_origin] *
          Trip.multiplier[@trip.pace] *
          (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Sarsaparilla") =>
        (5 * Trip.multiplier[@trip.city_of_origin] *
          Trip.multiplier[@trip.pace] *
          (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Apples") =>
        (5 * Trip.multiplier[@trip.city_of_origin] *
          Trip.multiplier[@trip.pace] *
          (@trip.children+@trip.adults)).to_i}
    @tools = {
      Product.find_by_name("Sleeping Bag") =>
        (@trip.children+@trip.adults).to_i,
      Product.find_by_name("Carpenter's Tools") =>
        ((@trip.children+@trip.adults)/2).to_i,
      Product.find_by_name("Medicine bag") =>
        ((@trip.children+@trip.adults)/2).to_i,
      Product.find_by_name("Stone Hunting Knife") =>
        (@trip.adults).to_i
    }

    render :show
  end

  def new
    @trip = Trip.new

    render :new
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def create
    @trip = Trip.new(params[:trip])

    if @trip.save
      redirect_to @trip, notice: 'Your trip has been planned.'
    end
  end

  def update
    @trip = Trip.find(params[:id])

    if @trip.update_attributes(params[:trip])
      redirect_to @trip, notice: 'Trip was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    redirect_to trips_path
  end
end
