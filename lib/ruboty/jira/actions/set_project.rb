module Ruboty
  module Jira
    module Actions
      class SetProject < Base
        def call
          message.reply(set_project)
        rescue => e
          message.reply(e.message)
        end

        private
        def set_project
          memory[message.to] = project
          "set to #{project} is #{message.to || 'default'}"
        end

        def project
          message[:project]
        end
      end
    end
  end
end
