require 'simplecov'
SimpleCov.start

require 'fakefs/spec_helpers'
$:.push File.expand_path("../lib", __FILE__)
require 'engage'
require 'helpers'

RSpec.configure do |config|
  config.include Helpers
  config.include FakeFS::SpecHelpers

  config.around(:each) do |example|
    silenced(:stdout) { example.run }
  end
end