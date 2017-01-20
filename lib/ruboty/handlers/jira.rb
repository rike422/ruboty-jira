module Ruboty
  module Handlers
    # Ruboty jira client
    class Jira < Base
      on(/jira project associate ?(?<project>.+)\z/,
        name: 'associate_project',
        description: 'Associate this channel with jira project')

      on(/jira details ?(?<issue>.+)/,
        name: 'issue_detail',
        description: 'issue')

      on(/jira comment on (?<issue>\S+) (?<comment>.+)/,
        name: 'comment',
        description: 'comment to issue')

      on(/jira assign (?<issue>\S+) to (?<assign_user>.+)/,
        name: 'assign',
        description: 'assign issue')

      on(%r{#{ENV['JIRA_URL']}\/browse\/?(?<issue>.+)},
        all: true,
        name: 'issue_detail',
        description: 'comment to issue')

      on(/jira user #(?<jira_id>.+) is @(?<chat_name>.+)/,
        name: 'associate_user',
        description: 'Associate jira_id with chat_name')

      on(/jira create (?<issue_type>\S+) (?<summary>\S+) ?(?<subject>.*)/,
        name: 'create_issue',
        description: 'Create issue to Jira project')

      env :JIRA_URL, 'https://jira-domain.com:9090'
      env :JIRA_PASSWORD, 'jira password'
      env :JIRA_USERNAME, 'jira username'
      env :JIRA_CONTEXT_PATH, 'jira context path', optional: true
      env :JIRA_USE_SSL, 'jira context path', optional: true

      def assign(message)
        Ruboty::Jira::Actions::Assgin.new(message).call
      end

      def associate_user(message)
        Ruboty::Jira::Actions::AssociateUser.new(message).call
      end

      def associate_project(message)
        Ruboty::Jira::Actions::AssociateProject.new(message).call
      end

      def comment(message)
        Ruboty::Jira::Actions::Comment.new(message).call
      end

      def create_issue(message)
        Ruboty::Jira::Actions::CreateIssue.new(message).call
      end

      def issue(message)
        Ruboty::Jira::Actions::Issue.new(message).call
      end

      def issue_detail(message)
        Ruboty::Jira::Actions::IssueDetail.new(message).call
      end
    end
  end
end
