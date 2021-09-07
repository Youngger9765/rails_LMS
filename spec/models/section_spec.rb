require 'rails_helper'

RSpec.describe Section, type: :model do
	describe 'associations' do
		it { should belong_to(:course) }
		it { should have_many(:contents) }
		it { should have_many(:videos).through(:contents).source(:contentable)  }
		it { should have_many(:powerpoints).through(:contents).source(:contentable) }
  end
end