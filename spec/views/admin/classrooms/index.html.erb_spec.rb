require 'rails_helper'

RSpec.describe "admin/classrooms/index", type: :view do
  before(:each) do
    assign(:admin_classrooms, [
      Admin::Classroom.create!(),
      Admin::Classroom.create!()
    ])
  end

  it "renders a list of admin/classrooms" do
    render
  end
end
