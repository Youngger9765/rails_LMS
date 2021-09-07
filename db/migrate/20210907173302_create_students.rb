class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students do |t|
      t.integer :user_id, :index => true
      t.integer :school_id, :index => true
      t.string :name
      t.integer :age
      t.string :city
      t.string :school_name
      t.string :school_type
      t.integer :grade
      t.timestamps
    end
  end
end
