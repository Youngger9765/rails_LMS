require 'rails_helper'

RSpec.describe Student, type: :model do
	describe 'associations' do
    it { should belong_to(:user) }
		it { should belong_to(:school) }
    it { should have_many(:classroom_student_ships) }
		it { should have_many(:classrooms).through(:classroom_student_ships) }
  end
end