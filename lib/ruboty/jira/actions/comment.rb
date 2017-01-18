module Ruboty
  module Jira
    module Actions
      class Comment < Base
        def call
          message.reply(comment)
        rescue => e
          message.reply(e.message)
        end

        private

        def comment
          # TODO: main logic
        end
      end
    end
  end
end
