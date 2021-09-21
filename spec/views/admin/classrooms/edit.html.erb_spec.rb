require 'rails_helper'

RSpec.describe "admin/classrooms/edit", type: :view do
  before(:each) do
    @admin_classroom = assign(:admin_classroom, Admin::Classroom.create!())
  end

  it "renders the edit admin_classroom form" do
    render

    assert_select "form[action=?][method=?]", admin_classroom_path(@admin_classroom), "post" do
    end
  end
end
