require 'rails_helper'

RSpec.describe "admin/sections/index", type: :view do
  before(:each) do
    assign(:admin_sections, [
      Admin::Section.create!(),
      Admin::Section.create!()
    ])
  end

  it "renders a list of admin/sections" do
    render
  end
end
