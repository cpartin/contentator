ActionController::Routing::Routes.draw do |map|

  map.namespace :cms do |cms|
    cms.namespace :admin, :path_prefix => '' do |admin|
      admin.resources :pages, :collection => [:update_page_tree]
      admin.resources :page_content_blocks, :collection => [:sort], :only => [:new, :create, :update, :edit, :destroy]
      admin.resources :file_attachments, :collection => [:sort], :only => [:new, :create, :destroy]
      admin.root :controller => 'pages', :action => 'index'
    end  
  end
    
  map.content '*path', :controller => 'cms/content', :action => 'show' 
end
