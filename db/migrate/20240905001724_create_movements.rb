class CreateMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :movements do |t|
      t.string :type
      t.string :description
      t.decimal :amount
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
