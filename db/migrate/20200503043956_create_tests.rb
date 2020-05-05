class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.date :day
      t.integer :types
      t.integer :english
      t.integer :math
      t.integer :japanese
      t.integer :science
      t.integer :society
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
