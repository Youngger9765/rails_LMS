require 'rails_helper'

RSpec.describe "admin/sections/show", type: :view do
  before(:each) do
    @admin_section = assign(:admin_section, Admin::Section.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
