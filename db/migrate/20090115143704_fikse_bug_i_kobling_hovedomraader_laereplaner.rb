class FikseBugIKoblingHovedomraaderLaereplaner < ActiveRecord::Migration
  def self.up
    remove_index :hovedomraader_laereplaner, :hovedomraade_uuid
    remove_index :hovedomraader_laereplaner, :laereplan_uuid
    
    drop_table :hovedomraader_laereplaner
    
    create_table :hovedomraader_laereplaner, :id => false do |t|
      t.integer :hovedomraade_id, :null => false
      t.integer :laereplan_id, :null => false
      t.timestamps
    end

    add_index :hovedomraader_laereplaner, :hovedomraade_id
    add_index :hovedomraader_laereplaner, :laereplan_id
  end

  def self.down
    remove_index :hovedomraader_laereplaner, :hovedomraade_id
    remove_index :hovedomraader_laereplaner, :laereplan_id
    
    drop_table :hovedomraader_laereplaner
    
    create_table :hovedomraader_laereplaner, :id => false do |t|
      t.integer :hovedomraade_uuid, :null => false
      t.integer :laereplan_uuid, :null => false
      t.timestamps
    end

    add_index :hovedomraader_laereplaner, :hovedomraade_uuid
    add_index :hovedomraader_laereplaner, :laereplan_uuid
  end
end
