class DropNewsletters < ActiveRecord::Migration
  def up
    drop_table :newsletters
  end

  def down
  end
end
