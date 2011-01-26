module Engage
  module Helpers

    def folder_name
      project.split("/").last
    end

    def file_path
      File.join(ENV["HOME"], ".engage.sources")
    end

    def sources
      File.exists?(file_path) ? YAML.load_file(file_path) : default_sources
    end

    def sources_table
      sources.each_with_index.to_a.map { |line| line.reverse }
    end

    def default_sources
      ["git@github.com"]
    end

    def store(source)
      list = sources
      return false if list.include?(source)
      list << source
      File.open(file_path, 'w') { |f| f.write(YAML.dump(list.compact)) }
    end
  end
end