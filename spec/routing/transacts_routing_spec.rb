require "spec_helper"

describe TransactsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/transacts/new" }.should route_to(:controller => "transacts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/transacts/1" }.should route_to(:controller => "transacts", :action => "show", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/transacts" }.should route_to(:controller => "transacts", :action => "create")
    end

  end
end
