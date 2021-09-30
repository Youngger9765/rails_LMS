require 'rails_helper'

RSpec.describe "admin/students/index", type: :view do
  before(:each) do
    assign(:admin_students, [
      Admin::Student.create!(),
      Admin::Student.create!()
    ])
  end

  it "renders a list of admin/students" do
    render
  end
end
