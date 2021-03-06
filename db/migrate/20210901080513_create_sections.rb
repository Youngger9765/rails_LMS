class CreateSections < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.integer :course_id, :index => true
      t.string :name, :index => true
      t.text :description
      t.integer :position_id
      t.timestamps
    end
  end
end
