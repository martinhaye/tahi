FactoryGirl.define do

  factory :manuscript_manager_template do
    sequence(:paper_type) {|n| "Research #{n}" }
    template do
      {
        phases: [{
          name: "Editorial",
          task_types: [Declaration::Task.to_s]
        }]
      }
    end
  end

end
