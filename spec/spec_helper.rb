require 'rubygems'
require 'fakefs/spec_helpers'
$:.push File.expand_path("../lib", __FILE__)
require 'engage'
require 'helpers'

RSpec.configure do |config|
  config.include Helpers
  config.include FakeFS::SpecHelpers
end

