class AddTotalToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :five_subjects, :integer
    add_column :tests, :three_subjects, :integer
  end
end
