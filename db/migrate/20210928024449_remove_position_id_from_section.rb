class RemovePositionIdFromSection < ActiveRecord::Migration[6.1]
  def change
    remove_column :sections, :position_id
  end
end
