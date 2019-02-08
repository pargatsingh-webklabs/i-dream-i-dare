require "rails_helper"

RSpec.describe NotificationPreferencesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/notification_preferences").to route_to("notification_preferences#index")
    end

    it "routes to #new" do
      expect(:get => "/notification_preferences/new").to route_to("notification_preferences#new")
    end

    it "routes to #show" do
      expect(:get => "/notification_preferences/1").to route_to("notification_preferences#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/notification_preferences/1/edit").to route_to("notification_preferences#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/notification_preferences").to route_to("notification_preferences#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/notification_preferences/1").to route_to("notification_preferences#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/notification_preferences/1").to route_to("notification_preferences#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/notification_preferences/1").to route_to("notification_preferences#destroy", :id => "1")
    end

  end
end
