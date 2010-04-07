class Page < ActiveRecord::Base
  TEMPLATES = I18n.t('cms.admin.pages.templates').collect{|k,v| v}
  
  translates :title, :subtitle, :template_name

  acts_as_tree :order => 'position'
  has_permalink :title, :slug, :scope => :parent_id
  
  has_many :page_content_blocks, :order => :position
  has_many :file_attachments, :as => :owner, :dependent => :destroy, :order => :position

  validates_presence_of :title
  validates_length_of :title, :within => 1..255, :message => I18n.t('cms.admin.pages.error_length')
  validates_presence_of :slug
  validates_uniqueness_of :slug, :scope => :parent_id, :message => I18n.t('cms.admin.pages.error_slug_unique')  
  validates_length_of :slug, :within => 1..255, :message => I18n.t('cms.admin.pages.error_length')      
  validates_format_of :slug, :with => /^[a-z\d\-]+$/, :message => I18n.t('cms.admin.pages.error_lowercase')
  # validates_associated :parent

  before_save :create_full_path
  before_save :check_parent

  named_scope :ordered, :order => :position
  named_scope :visible, :conditions => "visible = 1"
  
  def self.find_from_path(path)
    path = path.join("/")
    page = path.blank? ? Page.home_page : find_by_path(path)
  end

  def self.home_page
    Page.find_by_slug('home')
  end  

  def destroy
    if self == Page.home_page
      self.errors.add_to_base I18n.t('cms.admin.pages.error_delete_home')
      return
    end
    unless self.children.empty?
      self.errors.add_to_base I18n.t('cms.admin.pages.error_delete_children')
      return
    end
    super
  end

  protected
  def check_parent
    if self == Page.home_page
      self.parent_id = nil
      return
    end
    self.parent_id = 1 if self.parent_id.nil?
  end
  
  #Creates a URI path based on the Page tree
  def create_full_path
    return if self == Page.home_page

    self.parent.reload if self.parent
    if parent_node = self.parent
      # Build URI Path
      path = "#{parent_node.path}/#{self.slug}"
      # strip leading space, if there is one...
      path = path[1..-1] if path.starts_with? "/"
      self[:path] = path || ""
    else
      self[:path] = self.slug
    end
  end
end