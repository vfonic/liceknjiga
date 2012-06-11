class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.boolean :private, :default => false
      t.belongs_to :creator
      t.timestamps
    end
  end
end
