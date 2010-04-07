ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require 'shoulda'
require 'mocha'

class ActiveSupport::TestCase
  def deny(condition)
    assert ! condition
  end
end

