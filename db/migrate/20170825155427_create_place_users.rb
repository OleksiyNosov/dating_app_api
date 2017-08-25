class CreatePlaceUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :place_users do |t|
      t.references :user, foreign_key: true
      t.references :place, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
