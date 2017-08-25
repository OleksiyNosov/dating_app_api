class AddReviewsColumnToPlaceUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :place_users, :review, :text
  end
end
