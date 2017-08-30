class AddUniquenessForValueInAuthTokens < ActiveRecord::Migration[5.1]
  def change
    add_index :auth_tokens, :value, unique: true
  end
end
