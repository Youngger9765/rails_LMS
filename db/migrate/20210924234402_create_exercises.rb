class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.string :name, :index => true
      t.string :cover_range, :index => true
      t.boolean :is_random
      t.timestamps
    end
  end
end
