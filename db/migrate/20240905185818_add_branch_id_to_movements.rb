class AddBranchIdToMovements < ActiveRecord::Migration[6.1]
  def change
    add_column :movements, :branch_id, :integer
  end
end
