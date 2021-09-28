class AddPositionToSection < ActiveRecord::Migration[6.1]
  def change
    add_column :sections, :position, :integer
  end
end
