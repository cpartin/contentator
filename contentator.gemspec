# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{contentator}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Craig Partin"]
  s.date = %q{2010-04-07}
  s.description = %q{A lightweight cms that focuses on in place editing.}
  s.email = %q{cpartin@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.homepage = %q{http://github.com/cpartin/contentator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A lightweight cms that focuses on in place editing.}
  s.test_files = [
    "test/factories.rb",
     "test/functional/cms/admin/file_attachments_controller_test.rb",
     "test/functional/cms/admin/page_content_blocks_controller_test.rb",
     "test/functional/cms/admin/pages_controller_test.rb",
     "test/functional/cms/content_controller_test.rb",
     "test/performance/browsing_test.rb",
     "test/test_helper.rb",
     "test/unit/file_attachment_test.rb",
     "test/unit/page_content_block_test.rb",
     "test/unit/page_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 2.2.6"])
    else
      s.add_dependency(%q<haml>, [">= 2.2.6"])
    end
  else
    s.add_dependency(%q<haml>, [">= 2.2.6"])
  end
end