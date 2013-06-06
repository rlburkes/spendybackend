class AddWeekStartToUsers < ActiveRecord::Migration
  def change
    add_column :users, :week_start, :integer, :default => 6
  end
end
