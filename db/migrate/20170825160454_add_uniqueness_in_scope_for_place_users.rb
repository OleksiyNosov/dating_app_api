class AddUniquenessInScopeForPlaceUsers < ActiveRecord::Migration[5.1]
  def change
    add_index :place_users, %i[user_id place_id], unique: true
  end
end
