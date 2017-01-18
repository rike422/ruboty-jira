$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ruboty'
require 'ruboty/jira'

ENV['JIRA_USERNAME'] = 'akira.takahashi'
ENV['JIRA_PASSWORD'] = '******'
ENV['JIRA_URL'] = 'https://akira.takahashi.atlassian.net'
ENV['JIRA_CONTEXT_PATH'] = ''

if ENV['CI']
  require 'simplecov'
  require 'coveralls'
  require 'codeclimate-test-reporter'
  Coveralls.wear!
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[Coveralls::SimpleCov::Formatter]
  CodeClimate::TestReporter.start
end
