class EndreRelasjonMellomKompetansemaalsettOgTrinnTilMangeTilMange < ActiveRecord::Migration
  def self.up
    remove_column :kompetansemaalsett, :trinn_id
    
    create_table :kompetansemaalsett_trinn, :id => false do |t|
      t.integer :kompetansemaalsett_id, :null => false
      t.integer :trinn_id, :null => false
      t.timestamps
    end

    add_index :kompetansemaalsett_trinn, :kompetansemaalsett_id
    add_index :kompetansemaalsett_trinn, :trinn_id
  end

  def self.down
    remove_index :kompetansemaalsett_trinn, :kompetansemaalsett_id
    remove_index :kompetansemaalsett_trinn, :trinn_id
    
    drop_table :kompetansemaalsett_trinn
    
    add_column :kompetansemaalsett, :trinn_id, :integer
  end
end
