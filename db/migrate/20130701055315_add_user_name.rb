class AddUserName < ActiveRecord::Migration
  def up
    add_column('users','email',:string,:limit=>25)
  end

  def down
    remove_column('users','email')
  end
end
