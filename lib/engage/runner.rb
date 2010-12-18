module Engage
  class Runner < Thor::Group
    include Thor::Actions
    
    argument :name, :optional => true, :desc => "The targeted project name"
    
    def clone_repo
      run "git clone git@github.com:#{name}.git"
    end
    
    def generate_gemset
      gemset = name.split("/").last
      run "rvm gemset create #{gemset}"
    end
    
    def run_bundler
      path = name.split("/").last
      run "cd #{path} && bundle"
    end
  end
end
