class AddCurrencyLocaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :currency_locale, :string, :default => '$'
  end
end
