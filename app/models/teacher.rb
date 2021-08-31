class Teacher < ApplicationRecord

    has_many :classroom_teacher_ships
    has_many :classrooms, :through => :classroom_teacher_ships

    has_many :course_teacher_ships
    has_many :courses, :through => :course_teacher_ships

    belongs_to :user

end
