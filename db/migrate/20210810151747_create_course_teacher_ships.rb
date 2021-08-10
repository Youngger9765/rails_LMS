class CreateCourseTeacherShips < ActiveRecord::Migration[6.1]
  def change
    create_table :course_teacher_ships do |t|
      t.integer :course_id, :index => true
      t.integer :teacher_id, :index => true
      t.timestamps
    end
  end
end
