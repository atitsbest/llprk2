class ChangeOrderCountryToReference < ActiveRecord::Migration
  def change
      rename_column :orders, :country, :country_id
      add_foreign_key :orders, :countries;
  end
end
