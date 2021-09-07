require 'rails_helper'

RSpec.describe Classroom, type: :model do
	describe 'associations' do
		it { should belong_to(:school) }
		it { should have_many(:classroom_teacher_ships) }
		it { should have_many(:teachers).through(:classroom_teacher_ships) }
		it { should have_many(:classroom_student_ships) }
		it { should have_many(:students).through(:classroom_student_ships) }
		it { should have_many(:classroom_course_ships) }
		it { should have_many(:courses).through(:classroom_course_ships) }
  end
end