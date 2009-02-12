class CreateKompetansemaal < ActiveRecord::Migration
  def self.up
    create_table :kompetansemaal do |t|
      t.timestamps
      t.text :tittel
    end
  end

  def self.down
    drop_table :kompetansemaal
  end
end
