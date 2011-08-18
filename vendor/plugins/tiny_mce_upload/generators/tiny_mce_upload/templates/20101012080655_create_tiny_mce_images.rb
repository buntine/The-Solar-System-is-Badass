class CreateTinyMceImages < ActiveRecord::Migration
  def self.up
    create_table :tiny_mce_images do |t|
      t.string :alt
      t.string :file

      t.timestamps
    end
  end

  def self.down
    drop_table :tiny_mce_images
  end
end
