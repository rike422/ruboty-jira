module Ruboty
  module Jira
    module Actions
      class Issue_detail < Base
        def call
          message.reply(issue_detail)
        rescue => e
          message.reply(e.message)
        end

        private
        def issue_detail
          # TODO: main logic
        end
      end
    end
  end
end
