class EndreTittleTilTittelILaereplaner < ActiveRecord::Migration
  def self.up
    rename_column :laereplaner, :tittle, :tittel
  end

  def self.down
    rename_column :laereplaner, :tittel, :tittle
  end
end
