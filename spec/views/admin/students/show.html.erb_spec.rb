require 'rails_helper'

RSpec.describe "admin/students/show", type: :view do
  before(:each) do
    @admin_student = assign(:admin_student, Admin::Student.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
