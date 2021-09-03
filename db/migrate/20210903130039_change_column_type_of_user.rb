class ChangeColumnTypeOfUser < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :avatar, :text
  end
end
