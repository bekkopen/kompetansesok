class LeggeTilUuidIKompetansemaal < ActiveRecord::Migration
  def self.up
    add_column :kompetansemaal, :uuid, :string
  end

  def self.down
    remove_column :kompetansemaal, :uuid
  end
end
