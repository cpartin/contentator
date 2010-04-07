require 'test_helper'

class FileAttachmentTest < ActiveSupport::TestCase

  # Setup
  def setup
    @file_attachment = Factory(:file_attachment)
    @page = Page.find(@file_attachment.owner_id)
    @other_file_attachment = Factory(:other_file_attachment, :owner_id => @page.id)
  end
  subject { @file_attachment }  
  
  # Database
  should_have_db_column :owner_id,                :type => :integer
  should_have_db_column :owner_type,              :type => :string
  should_have_db_column :position,                :type => :integer
  should_have_db_column :visible,                 :type => :boolean
  should_have_db_column :file_file_name,          :type => :string
  should_have_db_column :file_content_type,       :type => :string
  should_have_db_column :file_file_size,          :type => :integer
  should_have_db_column :created_at,              :type => :datetime
  should_have_db_column :updated_at,              :type => :datetime
  
  # Relationships
  should_belong_to :owner

  # Validations
   
  should "be ordered from owner" do
    assert_equal [@file_attachment, @other_file_attachment], @page.file_attachments
  end
  
end