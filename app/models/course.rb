class Course < ApplicationRecord

    belongs_to :school

    has_many :course_teacher_ships
    has_many :teachers, :through => :course_teacher_ships

    has_many :sections

    has_many :classroom_course_ships
    has_many :classrooms, :through => :classroom_course_ships
end
