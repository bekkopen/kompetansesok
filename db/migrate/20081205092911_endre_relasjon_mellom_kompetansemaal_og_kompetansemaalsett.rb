class EndreRelasjonMellomKompetansemaalOgKompetansemaalsett < ActiveRecord::Migration
  def self.up
    remove_index :kompetansemaal_kompetansemaalsett, :kompetansemaal_id
    remove_index :kompetansemaal_kompetansemaalsett, :kompetansemaalsett_id
    drop_table :kompetansemaal_kompetansemaalsett

    add_column :kompetansemaal, :kompetansemaalsett_id, :integer
  end

  def self.down
    remove_column :kompetansemaal, :kompetansemaalsett_id

    create_table :kompetansemaal_kompetansemaalsett, :id => false do |t|
      t.integer :kompetansemaal_id, :null => false
      t.integer :kompetansemaalsett_id, :null => false
      t.timestamps
    end

    add_index :kompetansemaal_kompetansemaalsett, :kompetansemaal_id
    add_index :kompetansemaal_kompetansemaalsett, :kompetansemaalsett_id
  end
end
