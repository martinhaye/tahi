json.flows @flows do |flow|
  json.title flow.title
  json.empty_text flow.empty_text
  json.paperProfiles flow.tasks do |(paper, tasks)|
    json.paper_path manage_paper_path(paper)
    json.title paper.display_title
    json.tasks (tasks.map { |task| TaskPresenter.for(task).data_attributes })
  end
end
