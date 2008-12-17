class LeggTilKodeForHovedomraade < ActiveRecord::Migration
  def self.up
    add_column :hovedomraader, :kode, :string
  end

  def self.down
    remove_column :hovedomraader, :kode
  end
end
