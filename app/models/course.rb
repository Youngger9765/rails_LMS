class Course < ApplicationRecord

    belongs_to :school

    has_many :course_teacher_ships
    has_many :teachers, :through => :course_teacher_ships
end
