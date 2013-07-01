class NewUser < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password
      t.string :password_confirm

      t.timestamps
    end
  end

  def down
  end
end
