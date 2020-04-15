class AddIndexToUsersNumber < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :number, unique: true
  end
end
