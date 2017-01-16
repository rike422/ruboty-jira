module Ruboty
  module Jira
    module Actions
      class Issue < Base
        def call
          message.reply(issue)
        rescue => e
          message.reply(e.message)
        end

        private
        def issue
          # TODO: main logic
        end
      end
    end
  end
end
