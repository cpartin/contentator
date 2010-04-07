class Cms::Admin::<%= controller_class_name %>Controller < ApplicationController

  def new
    @<%= file_name %> = <%= class_name %>.new
    @page = Page.find(params[:page_id])
    render :partial => 'cms/admin/<%= table_name %>/form'  
  end

  def create
    @page = Page.find(params[:<%= file_name %>].delete('page_id'))
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])

    if @<%= file_name %>.save
      render :update do |page|
        page.replace_html 'new_<%= file_name %>_container', ''  
        page.replace_html '<%= table_name %>_container', :partial => 'cms/content/<%= table_name %>_container'
      end  
    else
      render :update do |page|
        page.replace_html 'new_<%= file_name %>_container', :partial => 'cms/admin/<%= table_name %>/form'  
      end  
    end
  end

  def edit
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @page = Page.find(params[:page_id])
    render :partial => 'cms/admin/<%= table_name %>/form'
  end

  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @page = Page.find(params[:<%= file_name %>].delete('page_id'))
  
    if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
      render :update do |page|
        page.replace_html '<%= table_name %>_container', :partial => 'cms/content/<%= table_name %>_container'
      end  
    else
      render :update do |page|
        page.replace_html "<%= file_name %>_", :partial => 'cms/admin/<%= table_name %>/form'  
      end  
    end
  end
  
  def destroy
    @page = Page.find(params[:page_id])
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy
    render :partial => 'cms/content/<%= table_name %>_container'
  end

  def sort
    @page = Page.find(params[:page_id])
    if params[:<%= table_name %>]
      params[:<%= table_name %>].each do |k,v|
        <%= file_name %> = <%= class_name %>.find(k)
        <%= file_name %>.update_attributes(:position => v)
      end
    end
    redirect_to content_path(@page.path) 
  end
end
