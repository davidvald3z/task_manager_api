class AddMovementDateToMovements < ActiveRecord::Migration[6.1]
  def change
    add_column :movements, :movement_date, :date
  end
end
