class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, :id => false do |t|
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps null: false
    end

    reversible do |dir|
        dir.up do
            execute "ALTER TABLE countries ADD PRIMARY KEY (code);"
            add_index :countries, :code, unique: true
        end
    end

    # Country.create :id => 'de', :name => 'Deutschland'
    # Country.create :id => 'at', :name => 'Österreich'
    # Country.create :id => 'ch', :name => 'Schweiz'
  end
end
