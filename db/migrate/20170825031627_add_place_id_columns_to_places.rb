class AddPlaceIdColumnsToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :place_id, :string
  end
end
