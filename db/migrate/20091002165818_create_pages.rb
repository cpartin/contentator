class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string      :title, :limit => 100  
      t.string      :subtitle, :limit => 100  
      t.string      :slug, :limit => 100
      t.string      :path
      t.string      :template_name
      t.integer     :position, :default => 0
      t.integer     :parent_id
      t.boolean     :visible
      t.boolean     :in_navigation
      t.timestamps
    end
    Page.create_translation_table! :title => :string, :subtitle => :string, :template_name => :string
  end 

  def self.down
    drop_table :pages
    Page.drop_translation_table!
  end
end
