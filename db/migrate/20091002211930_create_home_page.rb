class CreateHomePage < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO `pages` (id,title,template_name,slug,position,visible) VALUES (1,'Home', 'home','home',1,1)"
    execute "INSERT INTO `page_translations` (page_id,locale,title,template_name) VALUES (1, 'en', 'Home', 'home')"
  end

  def self.down
    Page.find_by_id(1).destroy
  end
end
