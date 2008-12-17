class CreateTrinn < ActiveRecord::Migration
  def self.up
    create_table :trinn do |t|
      t.string :uuid
      t.string :tittel
      t.timestamps
    end
    
    add_column :kompetansemaalsett, :trinn_id, :integer
  end

  def self.down
    remove_column :kompetansemaalsett, :trinn_id
    
    drop_table :trinn
  end
end
