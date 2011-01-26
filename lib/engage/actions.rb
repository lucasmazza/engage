module Engage
  module Actions
    include Thor::Actions

    def clone_repo
      source = ask_for_source
      run "git clone #{source}:#{project}.git"
    end

    def setup_rvm
      create_gemset
      create_rvmrc
      trust_rvmrc
    end

    def create_gemset
      run "rvm gemset create #{folder_name}"
    end

    def create_rvmrc
      create_file "#{folder_name}/.rvmrc", rvm_env
    end

    def trust_rvmrc
      run "rvm rvmrc trust #{folder_name}"
    end

    def run_bundler
      run "cd #{folder_name} && #{rvm_env} exec bundle"
    end

    protected

    def ask_for_source
      return sources.first if sources.size == 1
      list
      sources[ask("Select the git source of '#{folder_name}':").to_i]
    end

    def rvm_env
      "rvm #{RUBY_VERSION}@#{folder_name}"
    end

    def using_bundler?
      File.exists?(File.join(folder_name, "Gemfile"))
    end
  end
end