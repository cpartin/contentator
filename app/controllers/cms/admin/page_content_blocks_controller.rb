class Cms::Admin::PageContentBlocksController < ApplicationController

  def new
    @page = Page.find(params[:page_id])
    @page_content_block = @page.page_content_blocks.new
    render :partial => 'cms/admin/page_content_blocks/form'  
  end

  def edit
    @page_content_block = PageContentBlock.find(params[:id])
    @page = Page.find(@page_content_block.page_id)
    render :partial => 'cms/admin/page_content_blocks/form'  
  end

  def create
    @page = Page.find(params[:page_content_block][:page_id])
    @page_content_block = @page.page_content_blocks.new(params[:page_content_block])

    if @page_content_block.save
      responds_to_parent do
        render :update do |page|
          page.replace_html 'new_page_content_block', ''  
          page.replace_html 'page_content_blocks_container', :partial => 'cms/content/page_content_blocks_container' 
        end  
      end  
    else
      responds_to_parent do
        render :update do |page|
          page.replace_html "page_content_block_", :partial => 'cms/admin/page_content_blocks/form'  
        end  
      end  
    end  
  end

  def update
    @page_content_block = PageContentBlock.find(params[:id])
    @page = Page.find(@page_content_block.page_id)
    
    @page_content_block.photo = nil if params[:remove_image]   

    if @page_content_block.update_attributes(params[:page_content_block])
      responds_to_parent do
        render :update do |page|
          page.replace_html 'page_content_blocks_container', :partial => 'cms/content/page_content_blocks_container' 
        end  
      end  
    else
      responds_to_parent do
        render :update do |page|
          page.replace_html "page_content_block_", :partial => 'cms/admin/page_content_blocks/form'  
        end  
      end  
    end  
  end

  def destroy
    @page_content_block = PageContentBlock.find(params[:id])
    @page = Page.find(@page_content_block.page_id)
    @page_content_block.destroy
    render :update do |page|
      page.replace_html 'page_content_blocks_container', :partial => 'cms/content/page_content_blocks_container' 
    end  
  end

  def sort
    @page = Page.find(params[:page_id])
    if params[:page_content_block]
      position = 0
      params[:page_content_block].each do |id|
        page_content_block = @page.page_content_blocks.find(id)
        page_content_block.update_attributes(:position => position)
        position += 1
      end
    end
    render :nothing => true, :layout => false
  end
end
