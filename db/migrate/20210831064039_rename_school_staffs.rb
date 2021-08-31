class RenameSchoolStaffs < ActiveRecord::Migration[6.1]
  def change
    rename_table :school_staffs, :staffs
  end
end
