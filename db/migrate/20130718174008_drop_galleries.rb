class DropGalleries < ActiveRecord::Migration
  def up
    drop_table :galleries
  end

  def down
  end
end
