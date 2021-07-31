class CreateClassroomTeacherShips < ActiveRecord::Migration[6.1]
  def change
    create_table :classroom_teacher_ships do |t|
      t.integer :classroom_id
      t.integer :teacher_id

      t.timestamps
    end
  end
end
