require 'rails_helper'

RSpec.describe "admin/classrooms/new", type: :view do
  before(:each) do
    assign(:admin_classroom, Admin::Classroom.new())
  end

  it "renders new admin_classroom form" do
    render

    assert_select "form[action=?][method=?]", admin_classrooms_path, "post" do
    end
  end
end
