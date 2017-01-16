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
          use_ssl: use_ssl
          )
        end

        def fetch_project(key)
          client.Project.find(key)
        rescue
          log.error('JIRA HTTPError')
          nil
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

        def use_ssl
          ENV["JIRA_USE_SSL"] || true
        end

        def memory
          message.robot.brain.data[Ruboty::Jira::NAME_SPACE] ||= {}
        end

        def find_project(key)
          client.Project.find(key)
        rescue => e
          Ruboty.logger.error e
          Ruboty.logger.info('JIRA HTTPError')
          nil
        end

        def find_issue(key, expected = true)
          client.Issue.find(key)
        rescue
          log.error('JIRA HTTPError') if expected
          nil
        end

        def quey_issues(jql)
          client.Issue.jql(jql)
        end
      end
    end
  end
end
