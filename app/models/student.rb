class Student < ApplicationRecord
	belongs_to :user, optional: true
	belongs_to :school

	has_many :classroom_student_ships
	has_many :classrooms, :through => :classroom_student_ships
end
