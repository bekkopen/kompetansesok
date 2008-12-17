class OppretteMangeTilMangeMellomHovedomraaderOgLaereplaner < ActiveRecord::Migration
  def self.up
    create_table :hovedomraader_laereplaner, :id => false do |t|
      t.integer :hovedomraade_uuid, :null => false
      t.integer :laereplan_uuid, :null => false
      t.timestamps
    end

    add_index :hovedomraader_laereplaner, :hovedomraade_uuid
    add_index :hovedomraader_laereplaner, :laereplan_uuid
  end

  def self.down
    remove_index :hovedomraader_laereplaner, :hovedomraade_uuid
    remove_index :hovedomraader_laereplaner, :laereplan_uuid
    
    drop_table :hovedomraader_laereplaner
  end
end
