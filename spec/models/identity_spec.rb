require 'rails_helper'

RSpec.describe Identity, type: :model do
	describe 'associations' do
		it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:uid) }
		it { should validate_presence_of(:provider) }
		# TODO: fix validate_uniqueness_of :uid
		# it { should validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }
  end
end