module Ruboty
  module Handlers
    # Ruboty jira client
    class Jira < Base
      on /jira project set ?(?<project>.+)\z/, name: 'set_project', description: 'set project'
      on /jira ?(?<issue>.+)/, name: 'issue', description: 'issue'
      on /jira details ?(?<issue>.+)/, name: 'issue_detail', description: 'issue'
      on /jira comment ?(?<issue>.+) ?(?<comment>.+) /, name: 'comment', description: 'comment to issue'
      on /#{ENV["JIRA_URL"]}\/browse\/?(?<issue>.+)/, all: true, name: 'issue_detail', description: 'comment to issue'
      env :JIRA_URL, "https://jira-domain.com:9090"
      env :JIRA_PASSWORD, "jira password"
      env :JIRA_USERNAME, "jira username"
      env :JIRA_CONTEXT_PATH, "jira context path", optional: true
      env :JIRA_USE_SSL, "jira context path", optional: true

      def set_project(message)
        Ruboty::Jira::Actions::SetProject.new(message).call
      end

      def issue(message)
        Ruboty::Jira::Actions::Issue.new(message).call
      end

      def issue_detail(message)
        Ruboty::Jira::Actions::IssueDetail.new(message).call
      end

      def comment(message)
        Ruboty::Jira::Actions::Comment.new(message).call
      end
    end
  end
end
