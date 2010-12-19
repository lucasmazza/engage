module Engage
  class Runner < Thor::Group
    include Thor::Actions
    
    argument :name, :optional => true, :desc => "The targeted project name"
    
    def clone_repo
      source = ask_for_source
      run "git clone #{source}:#{name}.git"
    end
    
    def generate_gemset
      run "rvm gemset create #{project_name}"
    end
    
    def run_bundler
      run "cd #{project_name} && bundle" if using_bundler?
    end
    
    no_tasks do
      def ask_for_source
        return sources.first if sources.size == 1
        say "Available git servers:"
        sources.each_with_index do |source, index|
          say "#{index} => #{source}"
        end
        sources[ask("Select the server of '#{project_name}':")]
      end
      
      def using_bundler?
        File.exists?(File.join(project_name, "Gemfile"))
      end
      
      def project_name
        @project_name ||= name.split("/").last
      end
      
      def sources
        ["git@github.com"]
      end
      
    end
  end
end
