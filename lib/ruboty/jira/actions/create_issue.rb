module Ruboty
  module Jira
    module Actions
      class CreateIssue < Base
        def call
          return unless valid_project
          return unless valid_user
          issue = create_issue
          message.reply <<"EOF"
Create issue
#{jira_site}#{jira_context}/browse/#{issue.key}
EOF
        rescue => e
          message.reply(e.message)
        end

        private

        def valid_project
          return true unless associate_project.nil?
          message.reply <<ERROR
Please associate this channel with the jira project
ex: @Botname jira project associate <project_name>
ERROR
          false
        end

        def valid_user
          return true unless associate_user.nil?
          message.reply <<ERROR
Please associate chat name with the jira account
ex: @Botname jira user #<jira_user_name> is @<chat_name>
ERROR
          false
        end

        def create_issue
          issue = client.Issue.build
          issue.save(
            fields: {
              project: { id: associate_project[:id] },
              reporter: associate_user,
              summary: message[:summary],
              issuetype: { name: message[:issue_type] }
            }
          )
          issue.fetch
          issue
        end
      end
    end
  end
end
