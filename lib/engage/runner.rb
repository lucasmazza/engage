module Engage
  class Runner < Thor::Group
    include Thor::Actions
    
    argument :name, :optional => true, :desc => "The targeted project name"
    class_option :source, :type => :string, :desc => "Adds the given source to the user list."

    def self.banner
      "USAGE: engage [project] [--source SOURCE]"
    end
    
    def check_parameters
      if name.blank? && options.source.blank?
        say self.class.banner
        say_status 'quitting...', 'no arguments given.', :red
        raise SystemExit
      end
    end
    
    def clone_repo
      return if adding_source?
      source = ask_for_source
      run "git clone #{source}:#{name}.git"
    end
    
    def generate_gemset
      return if adding_source?
      run "rvm gemset create #{project_name}"
      create_file "#{project_name}/.rvmrc", selected_ruby
    end
    
    def run_bundler
      return if adding_source?
      run "cd #{project_name} && #{selected_ruby} exec bundle" if using_bundler?
    end
    
    def store
      return unless adding_source?
      list = sources
      list << options.source
      File.open(file_path, 'w') { |f| f.write(YAML.dump(list.uniq.compact)) }
    end
    
    no_tasks do
      def file_path
        File.join(ENV["HOME"], ".engage.sources")
      end
      
      def ask_for_source
        return sources.first if sources.size == 1
        say "Available git servers:"
        sources.each_with_index do |source, index|
          say "#{index} => #{source}"
        end
        sources[ask("Select the server of '#{project_name}':").to_i]
      end
      
      def using_bundler?
        File.exists?(File.join(project_name, "Gemfile"))
      end
      
      def project_name
        @project_name ||= name.split("/").last
      end
      
      def sources
        File.exists?(file_path) ? YAML.load_file(file_path) : default_sources
      end
      
      def default_sources
        ["git@github.com"]
      end
      
      def adding_source?
        options.source.present?
      end
      
      def rubyversion
        `rvm-prompt v`.strip
      end
      
      def selected_ruby
        "rvm #{rubyversion}@#{project_name}"
      end
      
    end
  end
end
