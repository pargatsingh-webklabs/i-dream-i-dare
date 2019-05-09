require "rails_helper"

RSpec.describe BioQuestionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bio_questions").to route_to("bio_questions#index")
    end

    it "routes to #new" do
      expect(:get => "/bio_questions/new").to route_to("bio_questions#new")
    end

    it "routes to #show" do
      expect(:get => "/bio_questions/1").to route_to("bio_questions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bio_questions/1/edit").to route_to("bio_questions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bio_questions").to route_to("bio_questions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bio_questions/1").to route_to("bio_questions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bio_questions/1").to route_to("bio_questions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bio_questions/1").to route_to("bio_questions#destroy", :id => "1")
    end

  end
end
