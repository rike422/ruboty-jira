module Ruboty
  module Jira
    module Actions
      class IssueDetail < Base
        def call
          message.reply(issue_detail)
        rescue => e
          message.reply(e.message)
        end

        private
        def issue_detail
          issue = find_issue(message[:issue])
          return issue.summary unless issue.nil?
        end
      end
    end
  end
end
