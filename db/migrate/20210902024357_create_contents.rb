class CreateContents < ActiveRecord::Migration[6.1]
  def change
    create_table :contents do |t|
      t.string :name, :index => true
      t.integer :section_id
      t.integer :contentable_id
      t.string :contentable_type
      t.timestamps
    end
  end
end
