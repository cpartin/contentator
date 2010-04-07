require 'test_helper'

class PageTest < ActiveSupport::TestCase

  # Setup
  def setup
    @home_page = Factory(:page, :slug => 'home', :path => 'home', :template_name => 'home', :parent_id => nil, :position => 34)
    Page.stubs(:home_page).returns(@home_page)
    @home_page.parent_id = nil
    @page = Factory(:page)
    @child = Factory(:page, :title => 'Child', :parent_id => @page.id, :visible => false, :position => 16)
  end
  subject { @page }  
  
  # Database
  should_have_db_column :template_name, :type => :string
  should_have_db_column :title,         :type => :string
  should_have_db_column :subtitle,      :type => :string
  should_have_db_column :slug,          :type => :string
  should_have_db_column :path,          :type => :string
  should_have_db_column :position,      :type => :integer
  should_have_db_column :parent_id,     :type => :integer
  should_have_db_column :visible,       :type => :boolean
  should_have_db_column :in_navigation, :type => :boolean
  should_have_db_column :created_at,    :type => :datetime
  should_have_db_column :updated_at,    :type => :datetime
  
  # Relationships
  should_have_many :page_content_blocks
  should_have_many :file_attachments
  
  # Validations
  should_validate_presence_of :title
    
  should "have templates home, content and gallery" do
    assert Page::TEMPLATES.include?('home')
    assert Page::TEMPLATES.include?('content')
    assert Page::TEMPLATES.include?('gallery')
  end

  should "act_as_tree" do
    assert_equal [@child], @page.children
  end

  should "find home page" do 
    home = Page.home_page
    assert_equal 'home', home.slug
  end
  
  should "find a page with a path" do
    test_page = Page.find_from_path(@page.path.split('/'))
    assert_equal @page, test_page
  end
  
  should "return nil if path not found" do
    page = Page.find_from_path(['a', 'nonexistant', 'path'])
    deny page
  end
  
  should "not destroy if children" do 
    @page.destroy
    assert @page
    assert @page.errors.on_base.include?('Cannot delete page with children. Please delete children first.')
  end
  
  should "not destroy if home page" do 
    @home_page.destroy
    assert @home_page
    assert @home_page.errors.on_base.include?('Cannot delete home page.')
  end
  
  should "have parent slug in path" do
    assert_equal "#{@page.path}/#{@child.slug}", @child.path
  end
  
  should "have templates constant of type array" do
    assert_equal Array, Page::TEMPLATES.class
    assert Page::TEMPLATES.length > 0
  end
  
  should "show visible" do
    assert_equal [@home_page, @page], Page.visible.all
  end

  should "be ordered" do
    assert_equal [@child, @page, @home_page], Page.ordered.all
  end

  should "not set parent_id of home page" do
    assert_equal nil, @home_page.parent_id
    @home_page.save
    assert_equal nil, @home_page.parent_id
    @home_page.update_attributes(:parent_id => 2)
    assert_equal nil, @home_page.parent_id
  end
  
  should "not allow parent_id to be null" do
    @page.parent_id = nil
    @page.save
    deny @page.reload.parent_id.nil?
  end
   
end