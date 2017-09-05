class AddExpiredAtColumnToAuthTokens < ActiveRecord::Migration[5.1]
  def change
    add_column :auth_tokens, :expired_at, :datetime
  end
end
