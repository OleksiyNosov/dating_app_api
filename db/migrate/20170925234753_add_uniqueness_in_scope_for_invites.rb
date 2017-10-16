class AddUniquenessInScopeForInvites < ActiveRecord::Migration[5.1]
  def change
    add_index :invites, %i[user_id event_id], unique: true
  end
end
