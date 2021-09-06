require "rails_helper"

RSpec.configure {|c| c.before { expect(controller).not_to be_nil }}

RSpec.describe SchoolsController do
  describe "#index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "assigns @schools" do
      school1 = create(:school)
      school2 = create(:school)
      school3 = create(:school)
      school4 = create(:school)
      school5 = create(:school)
      school6 = create(:school)
      get :index
      ans = [
        school1,
        school2,
        school3,
        school4,
        school5,
        school6
      ]
      page_num = 5
      expect(assigns(:schools)).to eq(ans[0..page_num-1])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe "#create" do
    context "with valid params {:name}" do
      it "should create a school" do
        expect do
          post :create, params: { :school => attributes_for(:school) }
        end.to change{ School.count }.by(1)
      end
      it "should redirect to schools_path" do
        post :create, params: { :school => attributes_for(:school) }
        expect(response).to redirect_to schools_path
      end
    end

    context "with invalid params {:name}" do
      it "should not create a school" do
        expect do
          post :create, params: { school: { :name => nil }}
        end.to change { School.count }.by(0)
      end
      it "should render new template" do
        post :create, params: { school: { :name => nil }}
        expect(response).to render_template(:new)
      end
    end
  end

  describe "#show" do
    it "assigns @school" do
      school = create(:school)
      get :show, params: { id: school.id }
      expect(assigns[:school]).to eq(school)
    end

    it "render template" do
      school = create(:school)
      get :show, params: { id: school.id }
      expect(response).to render_template("show")
    end
  end

  describe "#edit" do
    it "assign school" do
      school = create(:school)
      get :edit, params: { id: school.id }
      expect(assigns[:school]).to eq(school)
    end

    it "render template" do
      school = create(:school)
      get :edit, params: { id: school.id }
      expect(response).to render_template("edit")
    end
  end

  describe "#update" do
    it "assign @school" do
      school = create(:school)
      put :update , params: { id: school.id, school: { name: "Title", description: "Description" } }
      expect(assigns[:school]).to eq(school)
    end

    it "changes value" do
      school = create(:school)
      new_name = "new_name"
      new_description = "new description"
      put :update , params: { id: school.id, school: { name: new_name, description: new_description } }
      expect(assigns[:school].name).to eq(new_name)
      expect(assigns[:school].description).to eq(new_description)
    end

    it "redirects to school_path" do
      school = create(:school)
      put :update , params: { id: school.id, school: { name: "Title", description: "Description" } }
      expect(response).to redirect_to school_path(school)
    end
  end

  describe "#destroy" do
    it "assigns @school" do
      school = create(:school)
      delete :destroy, params: { id: school.id }
      expect(assigns[:school]).to eq(school)
    end

    it "deletes a record" do
      school = create(:school)
      expect { 
        delete :destroy, params: { id: school.id } 
      }.to change { School.count }.by(-1)
    end

    it "redirects to schools_path" do
      school = create(:school)
      delete :destroy, params: { id: school.id }
      expect(response).to redirect_to schools_path
    end
  end
end