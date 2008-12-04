class CreateKompetansemaalKompetansemaalsett < ActiveRecord::Migration
  def self.up
    create_table :kompetansemaal_kompetansemaalsett, :id => false do |t|
      t.integer :kompetansemaal_id, :null => false
      t.integer :kompetansemaalsett_id, :null => false
      t.timestamps
    end

    add_index :kompetansemaal_kompetansemaalsett, :kompetansemaal_id
    add_index :kompetansemaal_kompetansemaalsett, :kompetansemaalsett_id
  end

  def self.down
    remove_index :kompetansemaal_kompetansemaalsett, :kompetansemaal_id
    remove_index :kompetansemaal_kompetansemaalsett, :kompetansemaalsett_id
    drop_table :kompetansemaal_kompetansemaalsett
  end
end
