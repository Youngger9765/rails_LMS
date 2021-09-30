class AddStatusToClassroomCourseShip < ActiveRecord::Migration[6.1]
  def change
    add_column :classroom_course_ships, :status, :string
  end
end
