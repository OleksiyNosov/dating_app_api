class CreatePlaces < ActiveRecord::Migration[5.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :city
      t.string :tags, array: true, default: []
      t.float :lat
      t.float :lng
      t.float :overall_rating

      t.timestamps
    end
  end
end
