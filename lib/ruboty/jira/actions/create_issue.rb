module Ruboty
  module Jira
    module Actions
      class CreateIssue < Base
        def call
          return unless valid_project?
          return unless valid_user?
          issue = create_issue
          message.reply <<"EOF"
Create issue
#{jira_site}#{jira_context}/browse/#{issue.key}
EOF
        rescue => e
          message.reply(e.message)
        end

        private

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
