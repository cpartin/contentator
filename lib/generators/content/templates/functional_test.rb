require 'test_helper'
 
class Cms::Admin::<%= controller_class_name %>ControllerTest < ActionController::TestCase
  context '<%= controller_class_name.underscore %> controller' do

    setup do
      @page = Factory(:page)
      @<%= file_name %> = Factory(:<%= file_name %>)
      @<%= file_name %>2 = Factory(:<%= file_name %>, :position => 2)
    end

    should "route" do
      assert_recognizes(
        {:controller => "cms/admin/<%= table_name %>", :action => 'sort'},
        {:path => '/admin/<%= table_name %>/sort', :method => :post}
      )
      assert_recognizes(
        {:controller => "cms/admin/<%= table_name %>", :action => 'create'},
        {:path => '/admin/<%= table_name %>/', :method => :post}
      )
      assert_recognizes(
        {:controller => "cms/admin/<%= table_name %>", :action => 'new'},
        {:path => '/admin/<%= table_name %>/new', :method => :get}
      )
      assert_recognizes(
        {:controller => "cms/admin/<%= table_name %>", :action => 'edit', :id => '1'},
        {:path => '/admin/<%= table_name %>/1/edit', :method => :get}
      )
      assert_recognizes(
        {:controller => "cms/admin/<%= table_name %>", :action => 'update', :id => '1'},
        {:path => '/admin/<%= table_name %>/1', :method => :put}
      )
      assert_equal('/admin/<%= table_name %>/sort',  sort_cms_admin_<%= table_name %>_path())
      assert_equal('/admin/<%= table_name %>', cms_admin_<%= table_name %>_path())
      assert_equal('/admin/<%= table_name %>/new', new_cms_admin_<%= file_name %>_path())
      assert_equal('/admin/<%= table_name %>/1/edit', edit_cms_admin_<%= file_name %>_path(1))
      assert_equal('/admin/<%= table_name %>/1', cms_admin_<%= file_name %>_path(1))
    end

    context "on GET to :new" do
      setup { get :new, :page_id => @page.id }
    
      should_assign_to :<%= file_name %>
      should_respond_with :success
      should_render_template :form
    end
    
    context "on GET to :edit" do
      setup { get :edit, :page_id => @page.id, :id => @<%= file_name %>.id }
    
      should_assign_to :<%= file_name %>
      should_respond_with :success
      should_render_template :form
    end

    context "stubbed valid <%= file_name %>" do
      setup do
        <%= class_name %>.any_instance.stubs(:valid?).returns(true)
      end
    
      context "on POST to :create" do
        setup do
          post :create, :page_id => @page.id, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>).merge(:page_id => @page.id)
        end
    
        should_change('the number of <%= table_name %>', :by => 1 ) { <%= class_name %>.count }
        should_assign_to :<%= file_name %>
        should_render_template :<%= table_name %>_container
    
        should "save to db" do
          assert !assigns(:<%= file_name %>).new_record?
        end
      end
    
      context "on PUT to :update" do
        setup do
          put :update, :id => @<%= file_name %>.id, :<%= file_name %> => {:<%= attributes.first.name %> => <%= attributes.first.default.is_a?(String) ? "'#{attributes.first.default}_hello'" : attributes.first.default+1 %>, :page_id => @page.id}
        end
    
        should_assign_to :<%= file_name %>
        should_change('<%= file_name %> updated' ) { @<%= file_name %>.reload.updated_at }
        should_render_template :<%= table_name %>_container
      end
    end
    
    context "stubbed invalid <%= file_name %>" do
      setup do
        <%= class_name %>.any_instance.stubs(:valid?).returns(false)
      end
    
      context "on POST to :create" do
        setup do
          post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>).merge(:page_id => @page.id)
        end
    
        should_not_change('the number of <%= table_name %>') {<%= class_name %>.count}
        should_assign_to :<%= file_name %>
        should_render_template :form

        should "not save to db" do
          assert assigns(:<%= file_name %>).new_record?
        end
      end
    
      context "on PUT to :update" do
        setup do
          put :update, :id => @<%= file_name %>.id, :<%= file_name %> => { :updated_at => Time.now, :page_id => @page.id}
        end
    
        should_not_change('<%= file_name %> updated' ) { <%= class_name %>.find(@<%= file_name %>.id).updated_at }
        should_assign_to :<%= file_name %>
        should_render_template :form
      end
    end
    
    # must not be a parent of anything
    context "on DELETE to :destroy" do
      setup { get :destroy, :id => @<%= file_name %>.id, :page_id => @page.id}
    
      should_change('the number of <%= table_name %>', :by => -1 ) { <%= class_name %>.count }
      should_assign_to :<%= file_name %>
      should_render_template :<%= table_name %>_container
    end

    context "on POST to :sort" do
      setup do
        post :sort, :page_id => @page.id, :<%= table_name %> => {@<%= file_name %>.id => '2', @<%= file_name %>2.id => '1'}
      end

      should "sort <%= table_name %>" do
        assert_equal 2, @<%= file_name %>.reload.position
        assert_equal 1, @<%= file_name %>2.reload.position
      end
    
      should_assign_to :page
      should_redirect_to('content path') { content_path(@page.path) }
    end

  end
end