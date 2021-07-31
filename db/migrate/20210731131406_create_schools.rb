class CreateSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :schools do |t|
      t.string :name
      t.text :description
      t.boolean :is_public

      t.timestamps
    end
  end
end
