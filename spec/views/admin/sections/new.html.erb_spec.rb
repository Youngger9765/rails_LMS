require 'rails_helper'

RSpec.describe "admin/sections/new", type: :view do
  before(:each) do
    assign(:admin_section, Admin::Section.new())
  end

  it "renders new admin_section form" do
    render

    assert_select "form[action=?][method=?]", admin_sections_path, "post" do
    end
  end
end
