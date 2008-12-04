class CreateKompetansemaal < ActiveRecord::Migration
  def self.up
    create_table :kompetansemaal do |t|
      t.timestamps
      t.string :tittel
    end
  end

  def self.down
    drop_table :kompetansemaal
  end
end
