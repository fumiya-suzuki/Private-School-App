class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.integer :teacher_id
      t.string :subject
      t.string :note
      t.integer :admin_confirm, default: 0
      t.datetime :day
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
