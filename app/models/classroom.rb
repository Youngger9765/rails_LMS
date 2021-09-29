class Classroom < ApplicationRecord

    belongs_to :school

    has_many :classroom_teacher_ships
    has_many :teachers, :through => :classroom_teacher_ships

    has_many :classroom_student_ships
    has_many :students, :through => :classroom_student_ships do
      def is_applied
        where("classroom_student_ships.status = ?", "applied")
      end

      def is_registered
        where("classroom_student_ships.status = ?", "registered")
      end
    end

    has_many :classroom_course_ships
    has_many :courses, :through => :classroom_course_ships

end
