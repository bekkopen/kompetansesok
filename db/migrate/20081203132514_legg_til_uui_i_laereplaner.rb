class LeggTilUuiILaereplaner < ActiveRecord::Migration
  def self.up
    add_column :laereplaner, :uuid, :string
  end

  def self.down
    remove_column :laereplaner, :uuid
  end
end
