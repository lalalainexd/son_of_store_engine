require 'spec_helper'

describe TripsController do

  def valid_attributes
    { "children" => "1" }
  end

  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all trips as @trips" do

    end
  end

  describe "GET show" do
    it "assigns the requested trip as @trip" do

    end
  end

  describe "GET new" do
    it "assigns a new trip as @trip" do

    end
  end

  describe "GET edit" do
    it "assigns the requested trip as @trip" do

    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Trip" do
        expect {
          post :create, {:trip => valid_attributes}, valid_session
        }.to change(Trip, :count).by(1)
      end

      it "assigns a newly created trip as @trip" do
        post :create, {:trip => valid_attributes}, valid_session
        assigns(:trip).should be_a(Trip)
        assigns(:trip).should be_persisted
      end

      it "redirects to the created trip" do
        post :create, {:trip => valid_attributes}, valid_session
        response.should redirect_to(Trip.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved trip as @trip" do
       
      end

      it "re-renders the 'new' template" do
       
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested trip" do
        trip = Trip.create! valid_attributes
        # Assuming there are no other trips in the database, this
        # specifies that the Trip created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Trip.any_instance.should_receive(:update_attributes).with({ "children" => "1" })
        put :update, {:id => trip.to_param, :trip => { "children" => "1" }}, valid_session
      end

      it "assigns the requested trip as @trip" do
        trip = Trip.create! valid_attributes
        put :update, {:id => trip.to_param, :trip => valid_attributes}, valid_session
        assigns(:trip).should eq(trip)
      end

      it "redirects to the trip" do
        trip = Trip.create! valid_attributes
        put :update, {:id => trip.to_param, :trip => valid_attributes}, valid_session
        response.should redirect_to(trip)
      end
    end

    describe "with invalid params" do
      it "assigns the trip as @trip" do
        trip = Trip.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Trip.any_instance.stub(:save).and_return(false)
        put :update, {:id => trip.to_param, :trip => { "children" => "invalid value" }}, valid_session
        assigns(:trip).should eq(trip)
      end

      it "re-renders the 'edit' template" do
        trip = Trip.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Trip.any_instance.stub(:save).and_return(false)
        put :update, {:id => trip.to_param, :trip => { "children" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested trip" do
      # trip = Trip.create! valid_attributes
      # expect {
      #   delete :destroy, {:id => trip.to_param}, valid_session
      # }.to change(Trip, :count).by(-1)
    end

    it "redirects to the trips list" do
      
    end
  end

end
