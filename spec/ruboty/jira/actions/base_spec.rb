require 'spec_helper'

describe Ruboty::Jira::Actions::Base do
  let(:describe_class) { Ruboty::Jira::Actions::Base }
  let(:describe_instance) { describe_class.new(message) }
  let(:message) do
    {
      item: 'SugeeeItem'
    }
  end

  describe 'EMV' do
    let(:env_name) { 'ENV_VALUE' }
    shared_examples_for 'should be return environment variable' do
      before(:each) do
        allow(ENV).to receive(:[]).with(env_name).and_return(value)
      end
      it 'should be return JIRA_USERNAME' do
        expect(subject).to eq value
      end
    end
    describe '#username' do
      subject { describe_instance.jira_username }
      let(:env_name) { 'JIRA_USERNAME' }
      let(:value) { 'akira.takahashi' }
      it_behaves_like 'should be return environment variable'
    end
    describe '#password' do
      subject { describe_instance.jira_password }
      let(:env_name) { 'JIRA_PASSWORD' }
      let(:value) { 'password' }
      it_behaves_like 'should be return environment variable'
    end
    describe '#site' do
      subject { describe_instance.jira_site }
      let(:env_name) { 'JIRA_URL' }
      let(:value) { 'https://jiraurl.com//' }
      it_behaves_like 'should be return environment variable'
    end
    describe '#context' do
      subject { describe_instance.jira_context }
      let(:env_name) { 'JIRA_CONTEXT_PATH' }
      let(:value) { '/test' }
      it_behaves_like 'should be return environment variable'
      context 'when JIRA_CONTEXT_PATH is nil' do
        let(:value) { nil }
        it 'shoud be return emtpy string' do
          expect(subject).to eq ''
        end
      end
    end
    describe '#use_ssl' do
      subject { describe_instance.use_ssl }
      let(:env_name) { 'JIRA_USE_SSL' }
      let(:value) { false }
      it_behaves_like 'should be return environment variable'
      context 'when JIRA_USE_SSL is nil' do
        let(:value) { nil }
        it 'shoud be return true' do
          expect(subject).to eq true
        end
      end
    end
  end
end
