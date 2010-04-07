require File.join(File.dirname(__FILE__), '../../..', 'test_helper')

class Cms::Admin::PagesControllerTest < ActionController::TestCase
  context "page controller" do
    setup do
      @home_page = Factory(:page, :id => 1, :slug => 'home', :path => 'home', :template_name => 'home', :parent_id => nil)
      @page = Factory(:page, :parent_id => @home_page.id, :position => 2)
      @child1 = Factory(:page, :title => 'Child 1', :parent_id => @page.id, :position => 3)
      @child2 = Factory(:page, :title => 'Child 2', :parent_id => @page.id, :position => 4)
    end

    should "route" do
      assert_recognizes(
        {:controller => "cms/admin/pages", :action => 'index'},
        {:path => '/admin/pages', :method => :get}
      )
      assert_recognizes(
        {:controller => "cms/admin/pages", :action => 'create'},
        {:path => '/admin/pages/', :method => :post}
      )
      assert_recognizes(
        {:controller => "cms/admin/pages", :action => 'new'},
        {:path => '/admin/pages/new', :method => :get}
      )
      assert_recognizes(
        {:controller => "cms/admin/pages", :action => 'edit', :id => '1'},
        {:path => '/admin/pages/1/edit', :method => :get}
      )
      assert_recognizes(
        {:controller => "cms/admin/pages", :action => 'update', :id => '1'},
        {:path => '/admin/pages/1', :method => :put}
      )
      assert_recognizes(
        {:controller => "cms/admin/pages", :action => 'update_page_tree'},
        {:path => '/admin/pages/update_page_tree', :method => :get}
      )
      assert_equal('/admin/pages',  cms_admin_pages_path )
      assert_equal('/admin/pages', cms_admin_pages_path())
      assert_equal('/admin/pages/new', new_cms_admin_page_path())
      assert_equal('/admin/pages/1/edit', edit_cms_admin_page_path(1))
      assert_equal('/admin/pages/1', cms_admin_page_path(1))
      assert_equal('/admin/pages/update_page_tree', update_page_tree_cms_admin_pages_path())
    end

    context "on GET to :index" do
      setup { get :index }
    
      should_assign_to :pages
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end
    
    
    context "on GET to :new" do
      setup { get :new }
    
      should_assign_to :page
      should_respond_with :success
      should_render_template 'admin/pages/new'
    end
    
    context "on GET to :edit" do
      setup { get :edit, :id => @page.id }
    
      should_assign_to :page
      should_respond_with :success
      should_render_template 'admin/pages/edit'
    end
    
    context "stubbed valid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(true)
      end
    
      context "on POST to :create" do
        setup do
          post :create, :page => Factory.attributes_for(:page)
        end
    
        should_change('the number of pages', :by => 1 ) { Page.count }
        should_assign_to :page
        should_redirect_to('cms_admin_pages_path') { cms_admin_pages_path }
    
        should "save to db" do
          assert !assigns(:page).new_record?
        end
      end
    
      context "on PUT to :update" do
        setup do
          put :update, :id => @page.id, :page => { :title => 'new title', :subtitle => 'here we are', :template_name => 'gallery' }
        end
    
        should_assign_to :page
        should_change('page updated' ) { @page.reload.updated_at }
        should_redirect_to('cms_admin_pages_path') { cms_admin_pages_path }
      end
    end
    
    context "stubbed invalid page" do
      setup do
        Page.any_instance.stubs(:valid?).returns(false)
      end
    
      context "on POST to :create" do
        setup do
          post :create, :page => Factory.attributes_for(:page)
        end
    
        should_not_change('the number of pages') {Page.count}
        should_assign_to :page
        should_render_template 'admin/pages/new'
    
        should "not save to db" do
          assert assigns(:page).new_record?
        end
      end
    
      context "on PUT to :update" do
        setup do
          put :update, :id => @page.id, :page => { :updated_at => Time.now }
        end
    
        should_not_change('page updated' ) { Page.find(@page.id).updated_at }
        should_assign_to :page
        should_render_template 'admin/pages/edit'
      end
    end
    
    # must not be a parent of anything
    context "on DELETE to :destroy" do
      setup { get :destroy, :id => @child2.id }
    
      should_change('the number of pages', :by => -1 ) { Page.count }
      should_assign_to :page
      should_redirect_to('cms_admin_pages_path') { cms_admin_pages_path }
    end
    
    context "on POST to update_page_tree" do
      setup do
        assert_equal 2, @page.position
        assert_equal 3, @child1.position
        assert_equal 4, @child2.position
        assert_equal @page.id, @child1.parent_id
        assert_equal @page.id, @child2.parent_id
    
        post :update_page_tree,
          :tree_root => {"0"=>{"id"=>"#{@home_page.id}", "0"=>{"0"=>{"id"=>"#{@child2.id}"}, "id"=>"#{@page.id}", "1"=>{"id"=>"#{@child1.id}"}}}}
      end
      should_respond_with :success
    
      should "sort tree" do
        assert_equal 1, @home_page.reload.position
        assert_equal 2, @page.reload.position
        assert_equal 4, @child1.reload.position
        assert_equal 3, @child2.reload.position
        assert_equal @page.id, @child1.reload.parent_id
        assert_equal @page.id, @child2.reload.parent_id
      end
    end
  end
end

