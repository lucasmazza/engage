require 'engage/helpers'
require 'engage/actions'

module Engage
  class Runner < Thor
    include Engage::Actions
    include Engage::Helpers

    attr_accessor :project, :target_folder

    desc "init [PROJECT] [DIRECTORY]", "init a new project from one of the registered sources"
    def init(project, dir = nil)
      self.project = project
      self.target_folder = dir || project.split("/").last
      clone_repo
      setup_rvm
      run_bundler if using_bundler?
    end

    desc "list", "list all the registered sources"
    def list
      table = sources_table
      say "Available sources:"
      print_table(table, :colwidth => table.last.first.to_s.size, :ident => 3)
    end

    desc "add [SOURCE]", "register the given source to `~/.engage.sources`"
    def add(source)
      if store(source)
        say_status 'added source', source, :green
      else
        say_status 'duplicate', source, :red
      end
    end

  end
end
