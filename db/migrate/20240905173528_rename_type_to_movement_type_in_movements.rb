class RenameTypeToMovementTypeInMovements < ActiveRecord::Migration[6.1]
  def change
    rename_column :movements, :type, :movement_type
  end
end
