Factory.define :page do |f|
  f.title                           'Page'
  f.subtitle                        'Welcome to the website'
  f.path                            'page'
  f.template_name                   'content'
  f.position                        17
  f.parent_id                       { Factory.next :parent_id }
  f.visible                         true
  f.in_navigation                   true
  f.updated_at                      '2009-04-01 12:00:00'
end

Factory.sequence :parent_id do |n|
  n
end

Factory.define :page_content_block do |f|
  f.page_id                         { Factory(:page).id }
  f.title                           'Some content'
  f.text                            'lorem ipsum'
  f.position                        1
  f.visible                         true
  f.updated_at                      '2009-04-01 12:00:00'
end

Factory.define :file_attachment do |f|
  f.owner_id                        { Factory(:page).id }
  f.owner_type                      'Page'
  f.position                        1
  f.visible                         true
  f.updated_at                      '2009-04-01 12:00:00'
end

Factory.define :other_file_attachment, :class => 'FileAttachment' do |f|
  f.owner_id                        { Factory(:page).id }
  f.owner_type                      'Page'
  f.position                        2
  f.visible                         true
  f.updated_at                      '2009-04-01 12:00:00'
end