require 'rails_helper'

RSpec.describe Course, type: :model do
	describe 'associations' do
		it { should belong_to(:school) }
		it { should have_many(:course_teacher_ships) }
		it { should have_many(:teachers).through(:course_teacher_ships) }
		it { should have_many(:sections) }
        it { should have_many(:classroom_course_ships) }
		it { should have_many(:classrooms).through(:classroom_course_ships) }
  end
end