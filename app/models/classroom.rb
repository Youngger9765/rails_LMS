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

      def is_removed
        where("classroom_student_ships.status = ?", "removed")
      end
    end

    has_many :classroom_course_ships
    has_many :courses, :through => :classroom_course_ships do
      def is_added
        where("classroom_course_ships.status = ?", "added")
      end
      def is_removed
        where("classroom_course_ships.status = ?", "removed")
      end
    end

    def set_student_is_registered(student_id)
      ship = ClassroomStudentShip.find_by(classroom_id: self.id, student_id: student_id)
      ship.status = "registered"
      ship.save
    end

    def set_student_is_removed(student_id)
      ship = ClassroomStudentShip.find_by(classroom_id: self.id, student_id: student_id)
      ship.status = "removed"
      ship.save
    end

end
