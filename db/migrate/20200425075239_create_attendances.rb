class CreateAttendances < ActiveRecord::Migration[5.1]
  def change
    create_table :attendances do |t|
      t.date :worked_on
      t.integer :c_one
      t.integer :c_two
      t.integer :k_one
      t.integer :k_two
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
