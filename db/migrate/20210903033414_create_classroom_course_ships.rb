class CreateClassroomCourseShips < ActiveRecord::Migration[6.1]
  def change
    create_table :classroom_course_ships do |t|
      t.integer :classroom_id
      t.integer :course_id
      t.timestamps
    end
  end
end
