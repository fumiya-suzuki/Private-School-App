class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.date :day
      t.integer :types
      t.integer :english, default: 0
      t.integer :math, default: 0
      t.integer :japanese, default: 0
      t.integer :science, default: 0
      t.integer :society, default: 0
      t.text :comment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
