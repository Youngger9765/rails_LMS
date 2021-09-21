require 'rails_helper'

RSpec.describe "admin/sections/edit", type: :view do
  before(:each) do
    @admin_section = assign(:admin_section, Admin::Section.create!())
  end

  it "renders the edit admin_section form" do
    render

    assert_select "form[action=?][method=?]", admin_section_path(@admin_section), "post" do
    end
  end
end
