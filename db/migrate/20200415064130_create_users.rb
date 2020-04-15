class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :number
      t.string :name
      t.string :school
      t.string :tel
      t.boolean :admin
      t.boolean :teacher
      t.string :student
      t.string :boolean
      t.integer :grade

      t.timestamps
    end
  end
end
