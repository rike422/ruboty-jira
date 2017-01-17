require 'spec_helper'

describe Ruboty::Jira::Actions::AssociateUser do

  let(:describe_class) { Ruboty::Jira::Actions::AssociateUser }
  let(:describe_instance) { describe_class.new(message) }

  let(:jira_name) do
    'jira-takahashi'
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

  let(:said) do
    '@ruboty jira user #jira.takahashi is @akira.takahashi'
  end


  let(:replied) do
    'Registered.'
  end

  describe '#associate_user' do
    before(:each) do
      double = class_double('JIRA::Resource::User', name: jira_name)
      allow_any_instance_of(describe_class).to receive(:find_user).and_return(double)
    end

    it 'should associate with jira user name' do
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
      expect(robot.brain.data[Ruboty::Jira::NAME_SPACE]['USERS']).to eq(
        {
          'akira.takahashi' => {
            name: jira_name
          }
        })
    end
    context 'when the username not exist' do
      before(:each) do
        allow_any_instance_of(describe_class).to receive(:find_user).and_return(nil)
      end

      let(:replied) do
        'The jira account name is not found'
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