class CreateFag < ActiveRecord::Migration
  def self.up
    create_table :fag do |t|
      t.string :uuid
      t.string :kode
      t.text :tittel

      t.timestamps
    end
  end

  def self.down
    drop_table :fag
  end
end
