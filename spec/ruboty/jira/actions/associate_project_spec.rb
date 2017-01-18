require 'spec_helper'

describe Ruboty::Jira::Actions::AssociateProject do
  let(:describe_class) { Ruboty::Jira::Actions::AssociateProject }
  let(:describe_instance) { describe_class.new(message) }

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

  let(:said) do
    '@ruboty jira project set PRJ-MINE_100'
  end

  let(:replied) do
    'Registered.'
  end

  describe '#associate_project' do
    before(:each) do
      double = instance_double('JIRA::Resource::Project', id: project_id)
      allow_any_instance_of(describe_class).to receive(:find_project).and_return(double)
    end

    it 'should associate with jira project' do
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
      expect(robot.brain.data[Ruboty::Jira::NAME_SPACE]['PROJECTS']).to eq(
        to => {
          id: project_id
        }
      )
    end
    context 'when the username not exist' do
      before(:each) do
        allow_any_instance_of(describe_class).to receive(:find_project).and_return(nil)
      end

      let(:replied) do
        'The jira project is not found.'
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
