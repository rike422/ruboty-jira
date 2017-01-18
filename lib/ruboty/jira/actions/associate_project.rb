module Ruboty
  module Jira
    module Actions
      class AssociateProject < Base
        attr_reader :project

        def call
          set_project
          message.reply(replay_message)
        rescue => e
          message.reply(e.message)
        end

        private

        def associate_project
          @project = find_project(project_key)
          memory[message.to] = project.id unless project.nil?
        end

        def project_key
          message[:project]
        end

        def replay_message
          if project.nil?
            project_key.to_s
          else
            "set to #{project.id} is #{message.to || 'default'}"
          end
        end
      end
    end
  end
end
