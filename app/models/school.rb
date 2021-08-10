class School < ApplicationRecord
    validates_presence_of :name

    has_many :school_staffs
    has_many :classrooms
    has_many :courses 
end
