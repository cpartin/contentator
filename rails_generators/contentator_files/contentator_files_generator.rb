class ContentatorFilesGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      #copy all the cms files into the new project
      m.file '../../../config/routes.rb', 'config/routes.rb', :collision => :force

      m.directory('app/controllers/cms/admin')      
      m.directory('app/helpers/cms/admin')      

      m.file '../../../app/controllers/application_controller.rb', 'app/controllers/application_controller.rb', :collision => :force
      m.file '../../../app/controllers/cms/content_controller.rb', 'app/controllers/cms/content_controller.rb'
      m.file '../../../app/controllers/cms/admin/admin_controller.rb', 'app/controllers/cms/admin/admin_controller.rb'
      m.file '../../../app/controllers/cms/admin/page_content_blocks_controller.rb', 'app/controllers/cms/admin/page_content_blocks_controller.rb'
      m.file '../../../app/controllers/cms/admin/pages_controller.rb', 'app/controllers/cms/admin/pages_controller.rb'
      m.file '../../../app/controllers/cms/admin/file_attachments_controller.rb', 'app/controllers/cms/admin/file_attachments_controller.rb'
      m.file '../../../app/helpers/application_helper.rb', 'app/helpers/application_helper.rb', :collision => :force
      m.file '../../../app/helpers/cms/admin/pages_helper.rb', 'app/helpers/cms/admin/pages_helper.rb'
      m.file '../../../app/models/page.rb', 'app/models/page.rb'
      m.file '../../../app/models/page_content_block.rb', 'app/models/page_content_block.rb'
      m.file '../../../app/models/file_attachment.rb', 'app/models/file_attachment.rb'

      m.directory('app/views/cms/content')      
      m.directory('app/views/cms/admin')      
      m.directory('app/views/cms/admin/page_content_blocks')      
      m.directory('app/views/cms/admin/pages')      
      m.directory('app/views/cms/admin/file_attachments')      
      m.directory('app/views/layouts/cms/admin')      
      
      m.file '../../../app/views/cms/admin/_admin_toolbar.html.haml', 'app/views/cms/admin/_admin_toolbar.html.haml'
      m.file '../../../app/views/cms/admin/page_content_blocks/_form.html.haml', 'app/views/cms/admin/page_content_blocks/_form.html.haml'
      m.file '../../../app/views/cms/admin/file_attachments/_form.html.haml', 'app/views/cms/admin/file_attachments/_form.html.haml'
      m.file '../../../app/views/cms/admin/pages/_form.html.haml', 'app/views/cms/admin/pages/_form.html.haml'
      m.file '../../../app/views/cms/admin/pages/edit.html.haml', 'app/views/cms/admin/pages/edit.html.haml'
      m.file '../../../app/views/cms/admin/pages/index.html.haml', 'app/views/cms/admin/pages/index.html.haml'
      m.file '../../../app/views/cms/admin/pages/new.html.haml', 'app/views/cms/admin/pages/new.html.haml'
      m.file '../../../app/views/cms/content/_page_content_block.html.haml', 'app/views/cms/content/_page_content_block.html.haml'
      m.file '../../../app/views/cms/content/_page_content_blocks_container.html.haml', 'app/views/cms/content/_page_content_blocks_container.html.haml'
      m.file '../../../app/views/cms/content/content.html.haml', 'app/views/cms/content/content.html.haml'
      m.file '../../../app/views/cms/content/home.html.haml', 'app/views/cms/content/home.html.haml'
      m.file '../../../app/views/cms/content/gallery.html.haml', 'app/views/cms/content/gallery.html.haml'
      m.file '../../../app/views/cms/content/_file_attachment.html.haml', 'app/views/cms/content/_file_attachment.html.haml'
      m.file '../../../app/views/cms/content/_file_attachments_container.html.haml', 'app/views/cms/content/_file_attachments_container.html.haml'
      m.file '../../../app/views/layouts/application.html.haml', 'app/views/layouts/application.html.haml'
      m.file '../../../app/views/layouts/cms/admin/application.html.haml', 'app/views/layouts/cms/admin/application.html.haml'
      
      m.directory('db/migrate')      
      m.file '../../../db/migrate/20091002165818_create_pages.rb', 'db/migrate/20091002165818_create_pages.rb'
      m.file '../../../db/migrate/20091002211930_create_home_page.rb', 'db/migrate/20091002211930_create_home_page.rb'
      m.file '../../../db/migrate/20091007222703_create_page_content_blocks.rb', 'db/migrate/20091007222703_create_page_content_blocks.rb'
      m.file '../../../db/migrate/20091029204950_create_file_attachments.rb', 'db/migrate/20091029204950_create_file_attachments.rb'
      
      m.directory('public/images/admin_standard')      
      m.directory('public/images/icons')      
      
      m.file '../../../public/images/admin_standard/content-header-bg.png', 'public/images/admin_standard/content-header-bg.png'
      m.file '../../../public/images/admin_standard/context-arrow.png', 'public/images/admin_standard/context-arrow.png'
      m.file '../../../public/images/admin_standard/context-bg.png', 'public/images/admin_standard/context-bg.png'
      m.file '../../../public/images/admin_standard/crumb-bg-current.gif', 'public/images/admin_standard/crumb-bg-current.gif'
      m.file '../../../public/images/admin_standard/crumb-bg.gif', 'public/images/admin_standard/crumb-bg.gif'
      m.file '../../../public/images/admin_standard/crumb-divide-current.gif', 'public/images/admin_standard/crumb-divide-current.gif'
      m.file '../../../public/images/admin_standard/crumb-divide.gif', 'public/images/admin_standard/crumb-divide.gif'
      m.file '../../../public/images/admin_standard/drawer-end.png', 'public/images/admin_standard/drawer-end.png'
      m.file '../../../public/images/admin_standard/drawer-middle.png', 'public/images/admin_standard/drawer-middle.png'
      m.file '../../../public/images/admin_standard/drawer-start.png', 'public/images/admin_standard/drawer-start.png'
      m.file '../../../public/images/admin_standard/form-error.png', 'public/images/admin_standard/form-error.png'
      m.file '../../../public/images/admin_standard/input-background.gif', 'public/images/admin_standard/input-background.gif'
      m.file '../../../public/images/admin_standard/shadow-bottom.png', 'public/images/admin_standard/shadow-bottom.png'
      m.file '../../../public/images/admin_standard/shadow-right.png', 'public/images/admin_standard/shadow-right.png'
      m.file '../../../public/images/admin_standard/subnavigation-bullet-1.png', 'public/images/admin_standard/subnavigation-bullet-1.png'
      m.file '../../../public/images/admin_standard/subnavigation-bullet-2.png', 'public/images/admin_standard/subnavigation-bullet-2.png'
      m.file '../../../public/images/admin_standard/tab-active-cap.png', 'public/images/admin_standard/tab-active-cap.png'
      m.file '../../../public/images/admin_standard/tab-active.png', 'public/images/admin_standard/tab-active.png'
      m.file '../../../public/images/admin_standard/tab-inactive-cap.png', 'public/images/admin_standard/tab-inactive-cap.png'
      m.file '../../../public/images/admin_standard/tab-inactive.png', 'public/images/admin_standard/tab-inactive.png'

      m.file '../../../public/images/icons/add.png', 'public/images/icons/add.png'
      m.file '../../../public/images/icons/cancel.png', 'public/images/icons/cancel.png'
      m.file '../../../public/images/icons/delete.png', 'public/images/icons/delete.png'
      m.file '../../../public/images/icons/edit.png', 'public/images/icons/edit.png'
      m.file '../../../public/images/icons/folder.png', 'public/images/icons/folder.png'
      m.file '../../../public/images/icons/move.png', 'public/images/icons/move.png'
      
      m.file '../../../public/stylesheets/admin_standard.css', 'public/stylesheets/admin_standard.css'
      m.file '../../../public/stylesheets/application.css', 'public/stylesheets/application.css'

      #refused to just copy the file for some reason.  
      m.template 'application.rb', 'public/javascripts/application.js', :collision => :force
      
      m.file '../../../test/factories.rb', 'test/factories.rb'
      m.file '../../../test/test_helper.rb', 'test/test_helper.rb', :collision => :force

      m.directory('test/functional/cms/admin')      
      m.file '../../../test/functional/cms/admin/page_content_blocks_controller_test.rb', 'test/functional/cms/admin/page_content_blocks_controller_test.rb'
      m.file '../../../test/functional/cms/admin/pages_controller_test.rb', 'test/functional/cms/admin/pages_controller_test.rb'
      m.file '../../../test/functional/cms/admin/file_attachments_controller_test.rb', 'test/functional/cms/admin/file_attachments_controller_test.rb'
      m.file '../../../test/functional/cms/content_controller_test.rb', 'test/functional/cms/content_controller_test.rb'
      
      m.file '../../../test/unit/page_content_block_test.rb', 'test/unit/page_content_block_test.rb'
      m.file '../../../test/unit/page_test.rb', 'test/unit/page_test.rb'
      m.file '../../../test/unit/file_attachment_test.rb', 'test/unit/file_attachment_test.rb'

      m.file '../../../config/geminstaller.yml', 'config/geminstaller.yml'
      m.file '../../../config/geminstaller.local.yml', 'config/geminstaller.local.yml'
      m.file '../../../config/environment.rb', 'config/environment.rb', :collision => :force
      m.file '../../../config/locales/en.yml', 'config/locales/en.yml', :collision => :force
      m.file '../../../config/locales/de.yml', 'config/locales/de.yml'

      # copy custom content generator
      m.directory('lib/generators')      
      m.directory('lib/generators/content')      
      m.directory('lib/generators/content/templates')      

      m.file '../../../lib/generators/content/content_generator.rb', 'lib/generators/content/content_generator.rb'
      m.file '../../../lib/generators/content/templates/container.rb', 'lib/generators/content/templates/container.rb'
      m.file '../../../lib/generators/content/templates/controller.rb', 'lib/generators/content/templates/controller.rb'
      m.file '../../../lib/generators/content/templates/factories.rb', 'lib/generators/content/templates/factories.rb'
      m.file '../../../lib/generators/content/templates/form.rb', 'lib/generators/content/templates/form.rb'
      m.file '../../../lib/generators/content/templates/functional_test.rb', 'lib/generators/content/templates/functional_test.rb'
      m.file '../../../lib/generators/content/templates/item.rb', 'lib/generators/content/templates/item.rb'
      m.file '../../../lib/generators/content/templates/migration.rb', 'lib/generators/content/templates/migration.rb'
      m.file '../../../lib/generators/content/templates/model.rb', 'lib/generators/content/templates/model.rb'
      m.file '../../../lib/generators/content/templates/unit_test.rb', 'lib/generators/content/templates/unit_test.rb'
      m.file '../../../lib/generators/content/templates/view.rb', 'lib/generators/content/templates/view.rb'

    end
  end  
end