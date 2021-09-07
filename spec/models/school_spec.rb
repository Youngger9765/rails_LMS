require 'rails_helper'

RSpec.describe School, type: :model do
	describe 'associations' do
    it { should have_many(:staffs) }
		it { should have_many(:classrooms) }
    it { should have_many(:students) }
		it { should have_many(:courses) }
		it { should have_rich_text(:body) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

end