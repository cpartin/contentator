class Cms::Admin::PagesController < Cms::Admin::AdminController

  def index
    @pages = Page.ordered
  end

  def new
    @page = Page.new
    @pages = Page.ordered
  end

  def edit
    @page = Page.find(params[:id])
    @pages = Page.ordered
  end

  def create
    @page = Page.new(params[:page])
    @pages = Page.ordered

    if @page.save
      flash[:notice] = t('cms.admin.pages.flash_create')
      redirect_to(cms_admin_pages_path)
    else
      render :action => "new"
    end
  end

  def update
    @page = Page.find(params[:id])
    @pages = Page.ordered

    if @page.update_attributes(params[:page])
      flash[:notice] = t('cms.admin.pages.flash_update')
      redirect_to( cms_admin_pages_path )
    else
      render :action => "edit"
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = @page ? @page.errors.on_base : flash[:notice] = t('cms.admin.pages.flash_delete')
    redirect_to(cms_admin_pages_path)
  end

  def update_page_tree
    position = -1
    params[:tree_root].sort.each do |id, pos|
      save_tree params[:tree_root][id], nil, position += 1
    end
    render :nothing => true 
  end

  private
  # saves the tree structure and positions when updated
  def save_tree(node, parent_id, pos)
    id = node["id"]
    Page.update(id, :position => pos += 1, :parent_id => parent_id)

    node.delete("id")
    node.sort.each do |child|
      pos = save_tree(child[1], id, pos)
    end if node.length
    pos
  end
end
