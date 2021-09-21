require "rails_helper"

RSpec.describe Admin::ClassroomsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/classrooms").to route_to("admin/classrooms#index")
    end

    it "routes to #new" do
      expect(get: "/admin/classrooms/new").to route_to("admin/classrooms#new")
    end

    it "routes to #show" do
      expect(get: "/admin/classrooms/1").to route_to("admin/classrooms#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/classrooms/1/edit").to route_to("admin/classrooms#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/classrooms").to route_to("admin/classrooms#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/classrooms/1").to route_to("admin/classrooms#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/classrooms/1").to route_to("admin/classrooms#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/classrooms/1").to route_to("admin/classrooms#destroy", id: "1")
    end
  end
end
