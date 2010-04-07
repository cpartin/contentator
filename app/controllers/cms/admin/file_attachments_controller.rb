class Cms::Admin::FileAttachmentsController < Cms::Admin::AdminController

  def new
    @page = Page.find(params[:page_id])
    @file_attachment = FileAttachment.new
    render :partial => 'cms/admin/file_attachments/form'  
  end

  def create
    @page = Page.find(params[:file_attachment].delete('page_id'))

    @owner = params[:file_attachment][:owner_type].constantize.find(params[:file_attachment][:owner_id])
    @file_attachment = @owner.file_attachments.new(params[:file_attachment])

    if @file_attachment.save
      responds_to_parent do
        render :update do |page|
          page.replace_html 'new_file_attachment', ''  
          page.replace_html 'file_attachments_container', :partial => 'cms/content/file_attachments_container' 
        end  
      end  
    else
      responds_to_parent do
        render :update do |page|
          page.replace_html "file_attachment_", :partial => 'cms/admin/file_attachments/form'  
        end  
      end  
    end  
  end

  def destroy
    @page = Page.find(params[:page_id])
    @file_attachment = FileAttachment.find(params[:id])
    @file_attachment.destroy
    render :update do |page|
      page.replace_html 'file_attachments_container', :partial => 'cms/content/file_attachments_container' 
    end  
  end

  def sort
    @page = Page.find(params[:page_id])
    if params[:file_attachment]
      position = 0
      params[:file_attachment].each do |id|
        file_attachment = FileAttachment.find(id)
        file_attachment.update_attributes(:position => position)
        position += 1
      end
    end
    render :nothing => true, :layout => false
  end

end
