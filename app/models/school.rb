class School < ApplicationRecord
    validates_presence_of :name

    has_many :staffs
    has_many :classrooms
    has_many :students
    has_many :courses 

    has_rich_text :body
end
