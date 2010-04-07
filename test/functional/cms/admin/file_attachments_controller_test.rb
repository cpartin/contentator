require File.join(File.dirname(__FILE__), '../../..', 'test_helper')

class Cms::Admin::FileAttachmentsControllerTest < ActionController::TestCase
  context "file attachment controller" do
    setup do
      @file_attachment = Factory(:file_attachment)
      @page = Page.find(@file_attachment.owner_id)
      @file_attachment2 = Factory(:file_attachment, :position => 17)
      @file_attachment3 = Factory(:file_attachment, :position => 3)
    end

    should "route" do
      assert_recognizes(
        {:controller => "cms/admin/file_attachments", :action => 'sort'},
        {:path => '/admin/file_attachments/sort', :method => :post}
      )
      assert_recognizes(
        {:controller => "cms/admin/file_attachments", :action => 'create'},
        {:path => '/admin/file_attachments/', :method => :post}
      )
      assert_recognizes(
        {:controller => "cms/admin/file_attachments", :action => 'new'},
        {:path => '/admin/file_attachments/new', :method => :get}
      )
      assert_equal('/admin/file_attachments/sort',  sort_cms_admin_file_attachments_path())
      assert_equal('/admin/file_attachments',  cms_admin_file_attachments_path )
      assert_equal('/admin/file_attachments', cms_admin_file_attachments_path())
      assert_equal('/admin/file_attachments/1', cms_admin_file_attachment_path(1))
    end
    
    context "on POST to :new" do
      setup do
        post :new, :page_id => @page.id, :owner_type => @page.class.to_s, :owner_id => @page.id
      end
  
      should_assign_to :page
      should_assign_to :file_attachment
      should_render_template :form
      should_respond_with :success
    end

    context "stubbed valid file_attachment" do
      setup do
        FileAttachment.any_instance.stubs(:valid?).returns(true)
      end
    
      context "on POST to :create" do
        setup do
          post :create, :file_attachment => Factory.attributes_for(:file_attachment).merge(:owner_type => @page.class.to_s, :owner_id => @page.id, :page_id => @page.id)
        end
    
        should_change('the number of file_attachments', :by => 1 ) { FileAttachment.count }
        should_assign_to :page
        should_assign_to :owner
        should_assign_to :file_attachment
        should_render_template :file_attachments_container
        should_respond_with :success
    
        should "save to db" do
          assert !assigns(:file_attachment).new_record?
        end
      end
    end

    context "stubbed invalid page content block" do
      setup do
        FileAttachment.any_instance.stubs(:valid?).returns(false)
      end
  
      context "on POST to :create" do
        setup do
          post :create, :file_attachment => Factory.attributes_for(:file_attachment).merge(:owner_type => @page.class.to_s, :owner_id => @page.id, :page_id => @page.id)
        end
  
        should_not_change('the number of file_attachments') {FileAttachment.count}
        should_assign_to :page
        should_assign_to :owner
        should_assign_to :file_attachment
        should_render_template :form
        should_respond_with :success
  
        should "not save to db" do
          assert assigns(:file_attachment).new_record?
        end
      end
    end

    context "on DELETE to :destroy" do
      setup { get :destroy, :id => @file_attachment.id, :page_id => @page.id }
    
      should_change('the number of page content blocks', :by => -1 ) { FileAttachment.count }
      should_assign_to :page
      should_assign_to :file_attachment
      should_render_template :file_attachments_container
      should_respond_with :success
    end

    context "on POST to :sort" do
      should "sort file_attachment content blocks" do
        assert_equal 1, @file_attachment.position
        assert_equal 17, @file_attachment2.position
        assert_equal 3, @file_attachment3.position
      end

      setup do
        post :sort, :page_id => @page.id, :file_attachment => [@file_attachment3.id, @file_attachment.id, @file_attachment2.id ]
      end
    
      should "sort file_attachment content blocks" do
        assert_equal 1, @file_attachment.reload.position
        assert_equal 2, @file_attachment2.reload.position
        assert_equal 0, @file_attachment3.reload.position
      end
    
      should_assign_to :page
      should_render_without_layout()   
    end
  end  
end

