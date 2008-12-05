class LeggeTilIndexPaaUuidForLaereplanOgKompetansemaal < ActiveRecord::Migration
  def self.up
    add_index :kompetansemaal, :uuid
    add_index :laereplaner, :uuid
  end

  def self.down
    remove_index :kompetansemaal, :uuid
    remove_index :laereplaner, :uuid
  end
end
