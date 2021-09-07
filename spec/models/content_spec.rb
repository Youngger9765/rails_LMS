require 'rails_helper'

RSpec.describe Content, type: :model do
	describe 'associations' do
    it { should belong_to(:section) }
		it { should belong_to(:contentable) }
  end
end