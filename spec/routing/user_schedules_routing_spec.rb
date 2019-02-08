require "rails_helper"

RSpec.describe UserSchedulesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_schedules").to route_to("user_schedules#index")
    end

    it "routes to #new" do
      expect(:get => "/user_schedules/new").to route_to("user_schedules#new")
    end

    it "routes to #show" do
      expect(:get => "/user_schedules/1").to route_to("user_schedules#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_schedules/1/edit").to route_to("user_schedules#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_schedules").to route_to("user_schedules#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_schedules/1").to route_to("user_schedules#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_schedules/1").to route_to("user_schedules#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_schedules/1").to route_to("user_schedules#destroy", :id => "1")
    end

  end
end
