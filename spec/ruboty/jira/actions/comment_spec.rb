require 'spec_helper'

describe Ruboty::Jira::Actions::Comment do
  let(:describe_class) { Ruboty::Jira::Actions::Comment }
  let(:describe_instance) { describe_class.new(message) }

  let(:message) do
    {}
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

  let(:comment) do
    'Good Job!'
  end

  let(:said) do
    "@ruboty jira comment on #{issue_key} #{comment}"
  end

  let(:issue_key) { 'JIRA-1000' }

  let(:associate_user) do
    { name: 'akira.takahashi' }
  end
  let(:replied) do
    <<-"EOF"
Commented by @#{associate_user[:name]}
#{comment}
    EOF
  end

  describe '#comment' do
    before(:each) do
      allow_any_instance_of(describe_class).to receive(:associate_user).and_return(associate_user)
    end

    it 'should associate with jira project' do
      comment_double = instance_double(
        'JIRA::Resource::Comment',
        save!: true
      )
      issue_double = instance_double(
        'JIRA::Resource::Issue',
        comments: JIRA::Resource::Comment
      )

      allow_any_instance_of(describe_class).to receive(:find_issue).and_return(issue_double)
      allow(JIRA::Resource::Comment).to receive(:build).and_return(comment_double)

      expect(comment_double).to receive(:save!).with(
        hash_including(
          body: replied
        )
      )
      robot.receive(body: said, from: from, to: to)
    end
    context 'when the issue not exits' do
      before(:each) do
        allow_any_instance_of(describe_class).to receive(:find_issue).and_return(nil)
      end
      let(:replied) do
        "The issue #{issue_key} is not found"
      end
      it 'should reply error message' do
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
