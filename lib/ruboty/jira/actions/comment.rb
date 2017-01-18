module Ruboty
  module Jira
    module Actions
      class Comment < Base
        def call
          return unless valid_user?
          comment
        rescue => e
          message.reply(e.message)
        end

        private

        def comment
          issue = find_issue(message[:issue])
          return message.reply("The issue #{message[:issue]} is not found") if issue.nil?
          comment = issue.comments.build
          comment.save!(
            body: format(message[:comment])
          )
        end

        def format(message)
          <<-"EOF"
Commented by @#{associate_user[:name]}
#{message}
          EOF
        end
      end
    end
  end
end
