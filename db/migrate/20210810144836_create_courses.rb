class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.integer :school_id, :index => true
      t.string :name, :index => true
      t.text :description
      t.text :goal
      t.text :note
      t.text :tool
      t.timestamps
    end
  end
end
