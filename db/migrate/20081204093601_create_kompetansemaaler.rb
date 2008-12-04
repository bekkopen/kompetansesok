class CreateKompetansemaaler < ActiveRecord::Migration
  def self.up
    create_table :kompetansemaaler do |t|

      t.timestamps
      t.string :tittel
    end
  end

  def self.down
    drop_table :kompetansemaaler
  end
end
