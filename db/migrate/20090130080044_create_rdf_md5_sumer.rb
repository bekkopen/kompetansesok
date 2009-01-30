class CreateRdfMd5Sumer < ActiveRecord::Migration
  def self.up
    create_table :rdf_md5_sumer do |t|
      t.string :current
      t.timestamps
    end
  end

  def self.down
    drop_table :rdf_md5_sumer
  end
end
