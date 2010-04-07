module Rails
  module Generator
    module Commands
      class Create
        def create_factory
          template = File.read(source_path('factories.rb'))
          source_to_update = ERB.new(template, nil, '-').result(binding)
          File.open('test/factories.rb', 'a') { |file| file.write("\n\n#{source_to_update}") }
        end
        def route_namespaced_resources(resource)
          sentinel = "cms.namespace :admin, :path_prefix => '' do |admin|"
          logger.route "admin.resources #{resource}"
          unless options[:pretend]
            gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
              "#{match}\n\t\t\tadmin.resources :#{resource}, :collection => [:sort], :only => [:new, :create, :update, :edit, :destroy]"
            end
          end
        end
      end
      class Destroy
        def create_factory
          # pass can't undo right now
        end
        def route_namespaced_resources(resource)
          # pass can't undo right now
        end  
      end
    end
  end
end

class ContentGenerator < Rails::Generator::NamedBase
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method  :controller_file_name,  :controller_singular_name
  alias_method  :controller_table_name, :controller_plural_name

  def initialize(runtime_args, runtime_options = {})
    super

    @controller_name = @name.pluralize

    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end

  def manifest
    record do |m|
      #add position to attributes if not there already
      attributes << Rails::Generator::GeneratedAttribute.new('position', 'integer') unless attributes.map{|att| att.name == 'position'}

      # Check for class naming collisions.
      m.class_collisions(class_name, "#{class_name}Test", "#{class_name}Controller", "#{class_name}ControllerTest", "#{class_name}Helper")
      
      #namespace route under :cms :admin
      m.route_namespaced_resources(controller_file_name)

      # Controller, helper, views, and test directories.
      m.directory(File.join('app/models', class_path))
      m.directory(File.join('app/controllers/cms/admin', controller_class_path))
      m.directory(File.join('test/functional/cms/admin', controller_class_path))
      m.directory(File.join('test/unit', class_path))
      m.directory(File.join('app/views/cms/admin', controller_class_path, controller_file_name))

      m.template('controller.rb', File.join('app/controllers/cms/admin', controller_class_path, "#{controller_file_name}_controller.rb"))
      m.template('functional_test.rb', File.join('test/functional/cms/admin', controller_class_path, "#{controller_file_name}_controller_test.rb"))
      m.template 'model.rb', File.join('app/models', class_path, "#{file_name}.rb")
      m.template 'unit_test.rb', File.join('test/unit', class_path, "#{file_name}_test.rb")
      
      #make view code for model form and containers
      m.template 'form.rb', File.join('app/views/cms/admin', class_path, table_name, '_form.html.haml')
      m.template 'container.rb', File.join('app/views/cms/content', class_path, "_#{table_name}_container.html.haml")
      m.template 'item.rb', File.join('app/views/cms/content', class_path, "_#{file_name}.html.haml")
      
      m.create_factory      

      #make migration
      unless options[:skip_migration]
        m.migration_template 'migration.rb', 'db/migrate', :assigns => {
          :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
      end
    end
  end

  protected
  def banner
    "Usage: #{$0} content ModelName [field:type, field:type]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("--skip-timestamps",
           "Don't add timestamps to the migration file for this model") { |v| options[:skip_timestamps] = v }
    opt.on("--skip-migration",
           "Don't generate a migration file for this model") { |v| options[:skip_migration] = v }
  end

  def gsub_file(relative_destination, regexp, *args, &block)
    path = destination_path(relative_destination)
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end

end