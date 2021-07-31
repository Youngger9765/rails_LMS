class Classroom < ApplicationRecord

    belongs_to :school, class_name: "school", foreign_key: "school_id"
end
