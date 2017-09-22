class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.belongs_to :event, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :respond, default: 0

      t.timestamps
    end
  end
end
