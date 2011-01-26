module Engage
  module Actions
    include Thor::Actions

    def clone_repo
      source = ask_for_source
      run "git clone #{source}:#{project}.git #{target_folder}"
    end

    def setup_rvm
      create_gemset
      create_rvmrc
      trust_rvmrc
    end

    def create_gemset
      run "rvm gemset create #{target_folder}"
    end

    def create_rvmrc
      create_file "#{target_folder}/.rvmrc", rvm_env
    end

    def trust_rvmrc
      run "rvm rvmrc trust #{target_folder}"
    end

    def run_bundler
      run "cd #{target_folder} && #{rvm_env} exec bundle"
    end

    protected

    def ask_for_source
      return sources.first if sources.size == 1
      list
      sources[ask("Select the git source of '#{target_folder}':").to_i]
    end

    def rvm_env
      "rvm #{RUBY_VERSION}@#{target_folder}"
    end

    def using_bundler?
      File.exists?(File.join(target_folder, "Gemfile"))
    end
  end
end