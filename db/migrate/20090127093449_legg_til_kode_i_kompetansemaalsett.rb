class LeggTilKodeIKompetansemaalsett < ActiveRecord::Migration
  def self.up
    add_column :kompetansemaalsett, :kode, :string
  end

  def self.down
    remove_column :kompetansemaalsett, :kode
  end
end
