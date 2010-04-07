require File.join(File.dirname(__FILE__), '../../..', 'test_helper')

class Cms::Admin::PageContentBlocksControllerTest < ActionController::TestCase

  def setup
    @page_content_block = Factory(:page_content_block)
    @page = Page.find(@page_content_block.page_id)
    @page_content_block2 = Factory(:page_content_block, :position => 17, :page_id => @page.id)
    @page_content_block3 = Factory(:page_content_block, :position => 3, :page_id => @page.id)
  end

  should "route" do
    assert_recognizes(
      {:controller => "cms/admin/page_content_blocks", :action => 'sort'},
      {:path => '/admin/page_content_blocks/sort', :method => :post}
    )
    assert_recognizes(
      {:controller => "cms/admin/page_content_blocks", :action => 'create'},
      {:path => '/admin/page_content_blocks/', :method => :post}
    )
    assert_recognizes(
      {:controller => "cms/admin/page_content_blocks", :action => 'new'},
      {:path => '/admin/page_content_blocks/new', :method => :get}
    )
    assert_recognizes(
      {:controller => "cms/admin/page_content_blocks", :action => 'edit', :id => '1'},
      {:path => '/admin/page_content_blocks/1/edit', :method => :get}
    )
    assert_recognizes(
      {:controller => "cms/admin/page_content_blocks", :action => 'update', :id => '1'},
      {:path => '/admin/page_content_blocks/1', :method => :put}
    )
    assert_equal('/admin/page_content_blocks/sort',  sort_cms_admin_page_content_blocks_path())
    assert_equal('/admin/page_content_blocks', cms_admin_page_content_blocks_path())
    assert_equal('/admin/page_content_blocks/new', new_cms_admin_page_content_block_path())
    assert_equal('/admin/page_content_blocks/1/edit', edit_cms_admin_page_content_block_path(1))
    assert_equal('/admin/page_content_blocks/1', cms_admin_page_content_block_path(1))
  end
      
  context "on POST to :new" do
    setup do
      post :new, :page_id => @page.id
    end
  
    should_assign_to :page
    should_assign_to :page_content_block
    should_render_template :form
    should_respond_with :success
  end

  context "on GET to :edit" do
    setup { get :edit, :id => @page_content_block.id }
    
    should_assign_to :page
    should_assign_to :page_content_block
    should_render_template :form
    should_respond_with :success
  end

  context "stubbed valid page content block" do
    setup do
      PageContentBlock.any_instance.stubs(:valid?).returns(true)
    end
  
    context "on POST to :create" do
      setup do
        post :create, :page_content_block => Factory.attributes_for(:page_content_block), :page_id => @page.id
      end
  
      should_change('the number of page content blocks', :by => 1 ) { PageContentBlock.count }
      should_assign_to :page
      should_assign_to :page_content_block
      should_render_template :page_content_blocks_container
      should_respond_with :success
  
      should "save to db" do
        assert !assigns(:page_content_block).new_record?
      end
    end
  
    context "on PUT to :update" do
      setup do
        put :update, :id => @page_content_block.id, :page_content_block => { :title => 'new title' }
      end
      
      should_assign_to :page
      should_assign_to :page_content_block
      should_render_template :page_content_blocks_container
      should_respond_with :success
      should_change('page_content_block updated' ) { @page_content_block.reload.updated_at }
    end
  end
  
  context "stubbed invalid page content block" do
    setup do
      PageContentBlock.any_instance.stubs(:valid?).returns(false)
    end
  
    context "on POST to :create" do
      setup do
        post :create, :page_content_block => Factory.attributes_for(:page_content_block, :page_id => @page.id)
      end
  
      should_not_change('the number of page_content_blocks') {PageContentBlock.count}
      should_assign_to :page
      should_assign_to :page_content_block
      should_render_template :form
      should_respond_with :success
  
      should "not save to db" do
        assert assigns(:page_content_block).new_record?
      end
    end
  
    context "on PUT to :update" do
      setup do
        put :update, :id => @page_content_block.id, :page_content_block => { :updated_at => Time.now  }
      end
  
      should_not_change('page_content_block updated' ) { PageContentBlock.find(@page_content_block.id).updated_at }
      should_assign_to :page
      should_assign_to :page_content_block
      should_render_template :form
      should_respond_with :success
    end
  end

  context "on DELETE to :destroy" do
    setup { get :destroy, :id => @page_content_block.id }
    
    should_change('the number of page content blocks', :by => -1 ) { PageContentBlock.count }
    should_assign_to :page
    should_assign_to :page_content_block
    should_render_template :page_content_blocks_container
    should_respond_with :success
  end

  context "on POST to :sort" do
    should "sort page content blocks" do
      assert_equal 1, @page_content_block.position
      assert_equal 17, @page_content_block2.position
      assert_equal 3, @page_content_block3.position
    end

    setup do
      post :sort, :page_id => @page.id, :page_content_block => [ @page_content_block3.id, @page_content_block.id, @page_content_block2.id ]
    end

    should "sort page content blocks" do
      assert_equal 1, @page_content_block.reload.position
      assert_equal 2, @page_content_block2.reload.position
      assert_equal 0, @page_content_block3.reload.position
    end
    
    should_assign_to :page
    should_render_without_layout()   
  end

end
