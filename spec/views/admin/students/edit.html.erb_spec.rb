require 'rails_helper'

RSpec.describe "admin/students/edit", type: :view do
  before(:each) do
    @admin_student = assign(:admin_student, Admin::Student.create!())
  end

  it "renders the edit admin_student form" do
    render

    assert_select "form[action=?][method=?]", admin_student_path(@admin_student), "post" do
    end
  end
end
