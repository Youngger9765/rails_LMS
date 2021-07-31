class Teacher < ApplicationRecord

    has_many :classroom_teacher_ships
    has_many :classrooms, :through => :classroom_teacher_ships

end
