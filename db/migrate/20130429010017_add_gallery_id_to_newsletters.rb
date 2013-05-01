class AddGalleryIdToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :gallery_id, :integer
  end
end
