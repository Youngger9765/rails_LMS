class CreateSchoolStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :school_staffs do |t|
      t.string :name
      t.string :title
      t.integer :school_id
      t.integer :user_id

      t.timestamps
    end
  end
end
