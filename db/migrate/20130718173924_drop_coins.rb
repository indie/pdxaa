class DropCoins < ActiveRecord::Migration
  def up
    drop_table :coins
  end

  def down
  end
end
