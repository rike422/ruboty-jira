module Ruboty
  module Jira
    module Actions
      class Base < Ruboty::Actions::Base
        def client
          JIRA::Client.new(
            username: jira_username,
            password: jira_password,
            site: jira_site,
            context_path: jira_context,
            auth_type: :basic,
            use_ssl: use_ssl
          )
        end

        def jira_username
          ENV['JIRA_USERNAME']
        end

        def jira_password
          ENV['JIRA_PASSWORD']
        end

        def jira_site
          ENV['JIRA_URL']
        end

        def jira_context
          ENV['JIRA_CONTEXT_PATH'] || ''
        end

        def use_ssl
          value = ENV['JIRA_USE_SSL']
          return value unless value.nil?
          true
        end

        def memory
          message.robot.brain.data[Ruboty::Jira::NAME_SPACE] ||= {}
        end

        def users
          memory['USERS'] ||= {}
        end

        def projects
          memory['PROJECTS'] ||= {}
        end

        def associate_name
          user = users[message.from_name]
          return if user.nil?
          user[:name]
        end

        def associate_project
          projct = users[message.to]
          return if project.nil?
          projct
        end

        def find_project(key)
          client.Project.find(key)
        rescue => e
          Ruboty.logger.error e
          nil
        end

        def find_issue(key)
          client.Issue.find(key)
        rescue => e
          Ruboty.logger.error e
          nil
        end

        def find_user(key)
          client.User.find(key)
        rescue => e
          Ruboty.logger.error e
          nil
        end

        def query_issues(jql)
          client.Issue.jql(jql)
        end
      end
    end
  end
end
