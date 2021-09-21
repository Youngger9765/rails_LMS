require 'rails_helper'

RSpec.describe "admin/classrooms/show", type: :view do
  before(:each) do
    @admin_classroom = assign(:admin_classroom, Admin::Classroom.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
