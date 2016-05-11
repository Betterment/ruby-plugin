module WssAgent
  class RakeTasks
    include Rake::DSL if defined? Rake::DSL

    def install_tasks
      namespace :whitesource do
        desc 'Audit dependencies for CVEs and OSS licenses via Whitesource'
        task :audit do
          Specifications.update({})
          Specifications.check_policies({})
        end
      end
    end
  end
end

WssAgent::RakeTasks.new.install_tasks if File.split($0).last == 'rake'

