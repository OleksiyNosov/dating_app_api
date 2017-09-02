class AddIndexToPlaces < ActiveRecord::Migration[5.1]
  def up
    add_earthdistance_index :places
  end

  def down
    remove_earthdistance_index :places
  end
end
