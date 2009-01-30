class LeggTilUuiILaereplaner < ActiveRecord::Migration
  def self.up
    t.string :current
    add_column :laereplaner, :uuid, :string
  end

  def self.down
    remove_column :laereplaner, :uuid
  end
end
