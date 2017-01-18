module Ruboty
  module Jira
    module Actions
      class AssociateProject < Base
        def call
          associate_project
          replay_message
        rescue => e
          message.reply(e.message)
        end

        private

        def associate_project
          project = find_project(project_key)
          return if project.nil?

          projects[message.to] = {
            id: project.id
          }
        end

        def project_key
          message[:project]
        end

        def replay_message
          if associate_project.nil?
            message.reply('The jira project is not found.')
          else
            message.reply('Registered.')
          end
        end
      end
    end
  end
end
