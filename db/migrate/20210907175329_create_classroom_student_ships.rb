class CreateClassroomStudentShips < ActiveRecord::Migration[6.1]
  def change
    create_table :classroom_student_ships do |t|
      t.integer :classroom_id
      t.integer :student_id
      t.integer :number
      t.timestamps
    end
  end
end
