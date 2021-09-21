require "rails_helper"

RSpec.describe Admin::SectionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/admin/sections").to route_to("admin/sections#index")
    end

    it "routes to #new" do
      expect(get: "/admin/sections/new").to route_to("admin/sections#new")
    end

    it "routes to #show" do
      expect(get: "/admin/sections/1").to route_to("admin/sections#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/admin/sections/1/edit").to route_to("admin/sections#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/admin/sections").to route_to("admin/sections#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/admin/sections/1").to route_to("admin/sections#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/admin/sections/1").to route_to("admin/sections#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/admin/sections/1").to route_to("admin/sections#destroy", id: "1")
    end
  end
end
