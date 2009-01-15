class CreateFagKompetansemaalsett < ActiveRecord::Migration
  def self.up
    create_table :fag_kompetansemaalsett, :id => false do |t|
      t.integer :fag_id, :null => false
      t.integer :kompetansemaalsett_id, :null => false
      t.timestamps
    end

    add_index :fag_kompetansemaalsett, :fag_id
    add_index :fag_kompetansemaalsett, :kompetansemaalsett_id
  end

  def self.down
    remove_index :fag_kompetansemaalsett, :fag_id
    remove_index :fag_kompetansemaalsett, :kompetansemaalsett_id
    
    drop_table :fag_kompetansemaalsett
  end
end
