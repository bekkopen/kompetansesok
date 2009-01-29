class LeggeTilPsiForKompetansemaal < ActiveRecord::Migration
  def self.up
    add_column :kompetansemaal, :psi, :string
  end

  def self.down
    remove_column :kompetansemaal, :psi
  end
end
