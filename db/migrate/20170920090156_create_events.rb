class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.belongs_to :place, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.integer :kind, default: 0
      t.string :title
      t.text :description
      t.datetime :start_time

      t.timestamps
    end
  end
end
