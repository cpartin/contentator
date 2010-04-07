class CreatePageContentBlocks < ActiveRecord::Migration
  def self.up
    create_table :page_content_blocks do |t|
      t.references    :page
      t.string        :title
      t.text          :text
      t.integer       :position
      t.boolean       :visible
      t.string        :photo_file_name
      t.string        :photo_content_type
      t.integer       :photo_file_size
      t.string        :size
      t.timestamps
    end
    PageContentBlock.create_translation_table! :title => :string, :text => :text
  end

  def self.down
    drop_table :page_content_blocks
    PageContentBlock.drop_translation_table!
  end
end
