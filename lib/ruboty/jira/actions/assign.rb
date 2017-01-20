module Ruboty
  module Jira
    module Actions
      class Assign < Base
        def call
          unless assign_user.nil?
            reply_error_message
          else
            assign
          end
        rescue => e
          message.reply(e.message)
        end

        private

        def assign
          issue = find_issue(message[:issue])
          return message.reply("The issue #{message[:issue]} is not found") if issue.nil?
          assignee = issue.assignee.build
          assignee.save!(
            name: assign_user
          )
        end

        def assign_user
          return @assign_user unless @assign_user.nil?
          chat_name = message[:assign_user]
          return associate_user if chat == 'me'
          jira_user = jira_users[chat_name]
          @assign_user = jira_user
        end

        def reply_error_message
          message.reply <<-"ERROR_MESSAGE"
#{message[:assign_user]} has yet to be associated to jira account
Please associate chat name with the jira account
ex: @Botname jira user #<jira_user_name> is @<chat_name>
          ERROR_MESSAGE
        end
      end
    end
  end
end
