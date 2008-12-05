class OppretteRelasjonMellomKompetansemaalsettOgLaereplan < ActiveRecord::Migration
  def self.up
    remove_index :kompetansemaalsett_laereplaner, :kompetansemaalsett_id
    remove_index :kompetansemaalsett_laereplaner, :laereplan_id

    drop_table :kompetansemaalsett_laereplaner

    add_column :kompetansemaalsett, :laereplan_id, :integer

  end

  def self.down
    remove_column :kompetansemaalsett, :laereplan_id

    create_table :kompetansemaalsett_laereplaner, :id => false do |t|
      t.integer :kompetansemaalsett_id, :null => false
      t.integer :laereplan_id, :null => false
      t.timestamps
    end

    add_index :kompetansemaalsett_laereplaner, :kompetansemaalsett_id
    add_index :kompetansemaalsett_laereplaner, :laereplan_id

  end
end
