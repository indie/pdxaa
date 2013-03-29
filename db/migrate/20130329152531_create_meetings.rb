class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :day
      t.string :name
      t.string :address
      t.string :city
      t.string :codes
      t.string :map
      t.text :notes

      t.timestamps
    end
  end
end
