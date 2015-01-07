module WssAgent
  class CLI < Thor
    desc "config", "create config file"
    def config
      File.open(File.join(Dir.pwd, Configure::CURRENT_CONFIG_FILE), 'w') do |f|
        f << File.read(Configure.default_path)
      end
      ap 'created config file: wss_agent.yml'
    end

    desc 'list', 'display list dependencies'
    method_options all: :boolean
    method_options excludes: :string

    def list
      results = Specifications.list(options)
      ap results
    rescue Bundler::GemfileNotFound => ex
      ap ex.message
    rescue Bundler::GemNotFound => ex
      ap ex.message
      ap "Could you execute 'bundle install' before"
    end

    desc 'update', 'update list dependencies with server'
    method_options all: :boolean
    method_options excludes: :string

    def update
      Specifications.update(options)
    rescue => ex
      ap ex.message
    end
  end
end
