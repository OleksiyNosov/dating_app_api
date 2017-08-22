class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.datetime :birthday
      t.integer :gender, default: 0
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
