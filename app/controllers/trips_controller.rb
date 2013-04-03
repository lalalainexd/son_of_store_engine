class TripsController < ApplicationController
  def index
    @trips = Trip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trips }
    end
  end

  def show
    @trip = Trip.find(params[:id])
    # All numbers are meant for a group of 4
    @basics = {
      Product.find_by_name("Oxen") =>
        (4 * Trip.multiplier[@trip.city_of_origin]).to_i,
      Product.find_by_name("Guide") =>
        (1 * Trip.multiplier[@trip.city_of_origin]).to_i,
      Product.find_by_name("Tombstone") =>
        (1 * Trip.multiplier[@trip.city_of_origin]).to_i,
      Product.find_by_name("Kentucky Rifle") =>
        (1 * Trip.multiplier[@trip.city_of_origin]).to_i}
    @foods = {
      Product.find_by_name("Rations") =>
        (20 * Trip.multiplier[@trip.city_of_origin] *
          (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Bacon") =>
        (5 * Trip.multiplier[@trip.city_of_origin] *
          (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Sarsaparilla") =>
        (5 * Trip.multiplier[@trip.city_of_origin] *
          (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Apples") =>
        (5 * Trip.multiplier[@trip.city_of_origin] *
          (@trip.children+@trip.adults)).to_i}
    @tools = {
      Product.find_by_name("Basic Tunic") =>
        (2 * (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Basic Tunic") =>
        (2 * (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Basic Tunic") =>
        (2 * (@trip.children+@trip.adults)).to_i,
      Product.find_by_name("Basic Tunic") =>
        (2 * (@trip.children+@trip.adults)).to_i,
    }

    # @city = Trip.city_quantity_multipler[@trip.city_of_origin]
    # @pace = Trip.pace_quantity_multipler[@trip.pace]
    # @city_mult = Trip.city_quantity_multipler[@trip.city_of_origin]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trip }
    end
  end

  def new
    @trip = Trip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trip }
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def create

    @trip = Trip.new(params[:trip])


    #params passed in params[:trip]
     # {"children"=>"2",
     # "adults"=>"2",
     # "city_of_origin"=>"Independence,
     # Missouri",
     # "pace"=>"Steady",
     # "month_of_departure"=>"January"}

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render json: @trip, status: :created, location: @trip }
      else
        format.html { render action: "new" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @trip = Trip.find(params[:id])

    respond_to do |format|
      if @trip.update_attributes(params[:trip])
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy

    respond_to do |format|
      format.html { redirect_to trips_url }
      format.json { head :no_content }
    end
  end
end
