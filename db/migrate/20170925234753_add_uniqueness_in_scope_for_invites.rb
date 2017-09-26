class AddUniquenessInScopeForInvites < ActiveRecord::Migration[5.1]
  def change
    add_index :invites, [:user_id, :event_id], unique: true
  end
end
