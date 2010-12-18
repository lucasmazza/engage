module Engage
  class Runner < Thor::Group
    include Thor::Actions
    
    argument :name, :optional => true, :desc => "The targeted project name"
    
    def clone_repo
      run "git clone git@github.com:#{name}.git"
    end
    
    def generate_gemset
      run "rvm gemset create #{project_name}"
    end
    
    def run_bundler
      run "cd #{project_name} && bundle" if using_bundler?
    end
    
    no_tasks do
      def using_bundler?
        File.exists?(File.join(project_name, "Gemfile"))
      end
      
      def project_name
        @project_name ||= name.split("/").last
      end
    end
  end
end
