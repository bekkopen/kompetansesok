class LeggTilKodeForKompetansemaal < ActiveRecord::Migration
  def self.up
    add_column :kompetansemaal, :kode, :string
  end

  def self.down
    remove_column :kompetansemaal, :kode
  end
end
