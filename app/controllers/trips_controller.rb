class TripsController < ApplicationController
  def show
    @trip = Trip.find(params[:id])
    @basics = Trip.basics(@trip)
    @foods = Trip.foods(@trip)
    @tools = Trip.tools(@trip)

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

  # def destroy
  #   @trip = Trip.find(params[:id])
  #   @trip.destroy

  #   redirect_to trips_path
  # end
end
