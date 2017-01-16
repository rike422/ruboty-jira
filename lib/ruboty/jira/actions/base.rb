module Ruboty
  module Jira
    module Actions
      class Base < Ruboty::Actions::Base
        def client
          JIRA::Client.new(
          username: username,
          password: password,
          site: site,
          context_path: context,
          auth_type: :basic,
          use_ssl: true
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
          ENV["JIRA_CONTEXT_PATH"] || ''
        end

        def memory
          message.robot.brain.data[Ruboty::Jira::NAME_SPACE] ||= {}
        end

        def fetch_project(key)
          client.Project.find(key)
        rescue => e
          Ruboty.logger.error e
          Ruboty.logger.info('JIRA HTTPError')
          nil
        end

      end
    end
  end
end
