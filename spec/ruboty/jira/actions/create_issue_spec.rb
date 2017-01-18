require 'spec_helper'

describe Ruboty::Jira::Actions::CreateIssue do
  let(:describe_class) { Ruboty::Jira::Actions::CreateIssue }
  let(:describe_instance) { describe_class.new(message) }

  let(:message) do
    {}
  end
  let(:project_id) do
    100
  end

  let(:robot) do
    Ruboty::Robot.new
  end

  let(:from) do
    'akira.takahashi'
  end

  let(:to) do
    '#general'
  end

  let(:summary) do
    'RubotyでのJIRA操作'
  end

  let(:issue_type) { 'story' }

  let(:said) do
    "@ruboty jira create #{issue_type} #{summary}"
  end

  let(:create_issue_key) { 'JIRA-1000' }

  let(:replied) do
    <<"EOF"
Create issue
#{describe_instance.jira_site}#{describe_instance.jira_context}/browse/#{create_issue_key}
EOF
  end

  describe '#create_issue' do
    let(:associate_user) do
      {
        name: 'akira.takahashi'
      }
    end
    let(:project) do
      {
        id: project_id
      }
    end
    before(:each) do
      allow_any_instance_of(describe_class).to receive(:associate_user).and_return(associate_user)
      allow_any_instance_of(describe_class).to receive(:associate_project).and_return(project)
    end

    it 'should associate with jira project' do
      double = instance_double(
        'JIRA::Resource::Issue',
        id: project_id,
        save: true,
        fetch: true,
        method_missing: create_issue_key
      )
      allow(JIRA::Resource::Issue).to receive(:build).and_return(double)
      expect(robot).to receive(:say).with(
        body: replied,
        from: to,
        to: from,
        original: {
          body: said,
          from: from,
          robot: robot,
          to: to
        }
      )
      expect(double).to receive(:save).with(
        hash_including(
          fields: {
            project: project,
            reporter: associate_user,
            summary: summary,
            issuetype: { name: issue_type }
          }
        )
      )
      robot.receive(body: said, from: from, to: to)
    end
    context 'when channel has yet to be associated to project' do
      let(:replied) do
        <<-ERROR
Please associate this channel with the jira project
ex: @Botname jira project associate <project_name>
        ERROR
      end
      before(:each) do
        allow_any_instance_of(describe_class).to receive(:associate_project).and_return(nil)
      end
      it 'should return error message' do
        expect(robot).to receive(:say).with(
          body: replied,
          from: to,
          to: from,
          original: {
            body: said,
            from: from,
            robot: robot,
            to: to
          }
        )
        robot.receive(body: said, from: from, to: to)
      end
    end

    context 'when chat_name has yet to be associated to jira account' do
      let(:replied) do
        <<-ERROR
Please associate chat name with the jira account
ex: @Botname jira user #<jira_user_name> is @<chat_name>
        ERROR
      end
      before(:each) do
        allow_any_instance_of(describe_class).to receive(:associate_user).and_return(nil)
      end
      it 'should return error message' do
        expect(robot).to receive(:say).with(
          body: replied,
          from: to,
          to: from,
          original: {
            body: said,
            from: from,
            robot: robot,
            to: to
          }
        )
        robot.receive(body: said, from: from, to: to)
      end
    end
  end
end
