class CreateClassrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :classrooms do |t|
      t.string :name
      t.text :description
      t.boolean :is_public
      t.integer :school_id
      t.string :city
      t.string :school_name
      t.string :school_type
      t.integer :grade

      t.timestamps
    end
  end
end
