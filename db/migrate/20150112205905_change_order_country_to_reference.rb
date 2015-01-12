class ChangeOrderCountryToReference < ActiveRecord::Migration
  def change
      rename_column :orders, :country, :country_code
      add_index :orders, :country_code
  end
end
