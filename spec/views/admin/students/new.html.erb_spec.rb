require 'rails_helper'

RSpec.describe "admin/students/new", type: :view do
  before(:each) do
    assign(:admin_student, Admin::Student.new())
  end

  it "renders new admin_student form" do
    render

    assert_select "form[action=?][method=?]", admin_students_path, "post" do
    end
  end
end
