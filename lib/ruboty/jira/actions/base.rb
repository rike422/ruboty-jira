module Ruboty
  module Jira
    module Actions
      class Base < Ruboty::Actions::Base
        def client
          JIRA::Client.new(
          username: username,
          password: password,
          site: config.site,
          context_path: config.context,
          auth_type: :basic,
          use_ssl: config.use_ssl
          )
        end

        def username
          ENV["JIRA_USERNAME"]
        end

        def password
          ENV["JIRA_PASSWORD"]
        end

        def site
          ENV["JIRA_URL"]
        end

        def context
          ENV["JIRA_CONTEXT_PATH"]
        end

        def memory
          message.robot.brain.data[Ruboty::Jira::NAME_SPACE] ||= {}
        end
      end
    end
  end
end
