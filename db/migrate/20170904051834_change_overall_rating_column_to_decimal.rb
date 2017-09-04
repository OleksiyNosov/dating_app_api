class ChangeOverallRatingColumnToDecimal < ActiveRecord::Migration[5.1]
  def up
    change_column :places, :overall_rating, :decimal, precision: 3, scale: 2
  end

  def down
    change_column :places, :overall_rating, :float
  end
end
