class AddStatusToClassroomStudentShip < ActiveRecord::Migration[6.1]
  def change
    add_column :classroom_student_ships, :status, :string
  end
end
