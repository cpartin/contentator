class PageContentBlock < ActiveRecord::Base
  belongs_to :page
  has_many :file_attachments, :as => :owner, :dependent => :destroy, :order => :position

  translates :title, :text

  has_attached_file :photo, :url => "/images/:attachment/:id/:style_:basename.:extension", :path => ":rails_root/public/images/:attachment/:id/:style_:basename.:extension"

  named_scope :visible, :conditions => "visible = 1"
end