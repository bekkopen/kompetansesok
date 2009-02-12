class CreateKompetansemaalsett < ActiveRecord::Migration
  def self.up
    create_table :kompetansemaalsett do |t|
      t.string :uuid
      t.text :tittel

      t.timestamps
    end
    
    add_index :kompetansemaalsett, :uuid
    
    create_table :kompetansemaalsett_laereplaner, :id => false do |t|
      t.integer :kompetansemaalsett_id, :null => false
      t.integer :laereplan_id, :null => false
      t.timestamps
    end
    
    add_index :kompetansemaalsett_laereplaner, :kompetansemaalsett_id
    add_index :kompetansemaalsett_laereplaner, :laereplan_id
  end

  def self.down
    remove_index :kompetansemaalsett, :uuid
    remove_index :kompetansemaalsett_laereplaner, :kompetansemaalsett_id
    remove_index :kompetansemaalsett_laereplaner, :laereplan_id
    
    drop_table :kompetansemaalsett_laereplaner
    drop_table :kompetansemaalsett
  end
end
