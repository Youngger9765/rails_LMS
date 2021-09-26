 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/admin/courses", type: :request do
  
  # Admin::Course. As you add validations to Admin::Course, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Admin::Course.create! valid_attributes
      get admin_courses_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      course = Admin::Course.create! valid_attributes
      get admin_course_url(admin_course)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_admin_course_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      course = Admin::Course.create! valid_attributes
      get edit_admin_course_url(admin_course)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Admin::Course" do
        expect {
          post admin_courses_url, params: { admin_course: valid_attributes }
        }.to change(Admin::Course, :count).by(1)
      end

      it "redirects to the created admin_course" do
        post admin_courses_url, params: { admin_course: valid_attributes }
        expect(response).to redirect_to(admin_course_url(@admin_course))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Admin::Course" do
        expect {
          post admin_courses_url, params: { admin_course: invalid_attributes }
        }.to change(Admin::Course, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post admin_courses_url, params: { admin_course: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested admin_course" do
        course = Admin::Course.create! valid_attributes
        patch admin_course_url(admin_course), params: { admin_course: new_attributes }
        course.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the admin_course" do
        course = Admin::Course.create! valid_attributes
        patch admin_course_url(admin_course), params: { admin_course: new_attributes }
        course.reload
        expect(response).to redirect_to(admin_course_url(course))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        course = Admin::Course.create! valid_attributes
        patch admin_course_url(admin_course), params: { admin_course: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested admin_course" do
      course = Admin::Course.create! valid_attributes
      expect {
        delete admin_course_url(admin_course)
      }.to change(Admin::Course, :count).by(-1)
    end

    it "redirects to the admin_courses list" do
      course = Admin::Course.create! valid_attributes
      delete admin_course_url(admin_course)
      expect(response).to redirect_to(admin_courses_url)
    end
  end
end