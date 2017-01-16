require "jira-ruby"
require "ruboty/jira/version"
require "ruboty/handlers/jira"

require "ruboty/jira/actions/base"
require "ruboty/jira/actions/comment"
require "ruboty/jira/actions/issue_detail"
require "ruboty/jira/actions/issue"
require "ruboty/jira/actions/set_project"

module Ruboty
  module Jira
    NAME_SPACE = 'ruboty-jira'
  end
end
