class Classroom < ApplicationRecord

    belongs_to :school
    has_many :classroom_teacher_ships
    has_many :teachers, :through => :classroom_teacher_ships
end
