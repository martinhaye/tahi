require 'spec_helper'

describe TaskPolicy do
  describe "#tasks" do
    let(:user) { User.create! email: 'albert@example.org',
                 username: 'albert',
                 password: 'password',
                 password_confirmation: 'password' }
    let(:paper) { 
      Paper.create! short_title: "world_of_policies",
        journal: Journal.create!
    }

    let(:expected_tasks) do
      tasks = paper.task_manager.phases.collect(&:tasks).flatten
      expect(tasks.length).to be > 3
      tasks.first(3)
    end

    before do
      expected_tasks.each do |task|
        task.update assignee_id: user.id
      end
    end

    it "returns the tasks assigned to the current user" do
      expect(TaskPolicy.new(paper, user).tasks).to match_array(expected_tasks)
    end

    context "when the user is an editor on the paper" do
      let(:editor) { User.create! email: 'neil@example.org',
                       username: 'neil',
                       password: 'password',
                       password_confirmation: 'password' }

      let(:expected_tasks) do
        Task.where(phase_id: paper.task_manager.phase_ids, role: 'editor')
      end

      let!(:reviewer_task) {
        Task.create! title: 'Reviewer Report', role: 'reviewer', phase: paper.task_manager.phases.first
      }

      before do
        paper.paper_roles.create! user: editor, editor: true

        expected_tasks.each do |task|
          task.update assignee_id: editor.id
        end
      end

      it "returns the tasks assigned to the user and all reviewers of the paper" do
        expect(TaskPolicy.new(paper, editor).tasks).to match_array(expected_tasks + [reviewer_task])
      end
    end
  end
end