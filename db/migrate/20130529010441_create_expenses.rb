class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.integer :user_id

      t.timestamps
    end
    add_index :expenses, [:user_id, :created_at]
  end
end
