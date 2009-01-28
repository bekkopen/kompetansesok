class CreateInfo < ActiveRecord::Migration
  def self.up
    create_table :info do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :info
  end
end
