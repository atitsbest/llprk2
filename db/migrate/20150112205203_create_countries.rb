class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, :id => false do |t|
      t.primary_key :id, :string
      t.string :name, null: false

      t.timestamps null: false
    end

    reversible do |dir|
        dir.up do
            # Country.create :id => 'de', :name => 'Deutschland'
            # Country.create :id => 'at', :name => 'Österreich'
            # Country.create :id => 'ch', :name => 'Schweiz'
        end
    end
  end
end
