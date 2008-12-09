class CreateHovedomraader < ActiveRecord::Migration
  def self.up
    create_table :hovedomraader do |t|
      t.string :uuid
      t.string :tittel
      t.timestamps
    end
    add_index :hovedomraader, :uuid
    
    create_table :hovedomraader_kompetansemaal, :id => false do |t|
      t.integer :hovedomraade_id, :null => false
      t.integer :kompetansemaal_id, :null => false
      t.timestamps
    end
    add_index :hovedomraader_kompetansemaal, :hovedomraade_id
    add_index :hovedomraader_kompetansemaal, :kompetansemaal_id
  end

  def self.down
    remove_index :hovedomraader_kompetansemaal, :hovedomraade_id
    remove_index :hovedomraader_kompetansemaal, :kompetansemaal_id
    drop_table :hovedomraader_kompetansemaal  

    remove_index :hovedomraader, :uuid
    drop_table :hovedomraader
  end
end
