class AddGroupIdToExercises < ActiveRecord::Migration[5.0]
  def change
    add_column :exercises, :group_id, :integer
  end
end
