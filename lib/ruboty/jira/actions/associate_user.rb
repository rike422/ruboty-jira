module Ruboty
  module Jira
    module Actions
      class AssociateUser < Base
        def call
          associate
          reply_message
        rescue => e
          message.reply(e.message)
        end

        private

        def associate
          user = find_user(message[:jira_id])
          return if user.nil?
          users[message[:chat_name]] = {
            name: user.name
          }
        end

        def reply_message
          if associate_name.nil?
            message.reply('The jira account name is not found')
          else
            message.reply('Registered.')
          end
        end
      end
    end
  end
end
