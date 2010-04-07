class FileAttachment < ActiveRecord::Base
  belongs_to :owner, :polymorphic => true
  has_attached_file :file, :url => "/images/:attachment/:id/:style_:basename.:extension", :path => ":rails_root/public/images/:attachment/:id/:style_:basename.:extension"
end