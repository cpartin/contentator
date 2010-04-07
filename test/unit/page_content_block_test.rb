require 'test_helper'

class PageContentBlockTest < ActiveSupport::TestCase

  # Setup
  def setup
    @page_content_block = Factory(:page_content_block)
    @page = Page.find(@page_content_block.page_id)
    @page_content_block2 = Factory(:page_content_block, :page_id => @page.id, :position => 2)
    @page_content_block3 = Factory(:page_content_block, :page_id => @page.id, :position => 3, :visible => false)
  end
  subject { @page_content_block }  
  
  # Database
  should_have_db_column :page_id,             :type => :integer
  should_have_db_column :title,               :type => :string
  should_have_db_column :text,                :type => :text
  should_have_db_column :position,            :type => :integer
  should_have_db_column :visible,             :type => :boolean
  should_have_db_column :photo_file_name,     :type => :string
  should_have_db_column :photo_content_type,  :type => :string
  should_have_db_column :photo_file_size,     :type => :integer
  should_have_db_column :created_at,          :type => :datetime
  should_have_db_column :updated_at,          :type => :datetime
  
  # Relationships
  should_belong_to :page
  should_have_many :file_attachments

  # Validations
   
  should "show visible" do
    assert_equal [@page_content_block, @page_content_block2], PageContentBlock.visible.all
  end

  should "be ordered from page" do
    assert_equal [@page_content_block, @page_content_block2, @page_content_block3], @page.page_content_blocks
  end
  
end