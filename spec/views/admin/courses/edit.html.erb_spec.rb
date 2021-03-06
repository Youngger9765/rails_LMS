require 'rails_helper'

RSpec.describe "admin/courses/edit", type: :view do
  before(:each) do
    @admin_course = assign(:admin_course, Admin::Course.create!())
  end

  it "renders the edit admin_course form" do
    render

    assert_select "form[action=?][method=?]", admin_course_path(@admin_course), "post" do
    end
  end
end
