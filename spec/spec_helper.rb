$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruboty'
require 'ruboty/jira'

ENV['JIRA_USERNAME'] = 'akira.takahashi'
ENV['JIRA_PASSWORD'] = '******'
ENV['JIRA_URL'] = 'https://akira.takahashi.atlassian.net'
ENV['JIRA_CONTEXT_PATH'] = ''

if ENV['CI']
  require 'simplecov'
  require 'codeclimate-test-reporter'
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
  SimpleCov.start
end
