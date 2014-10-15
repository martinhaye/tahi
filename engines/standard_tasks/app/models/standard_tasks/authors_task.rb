module StandardTasks
  class AuthorsTask < Task
    include MetadataTask

    title "Add Authors"
    role "author"

    def active_model_serializer
      TaskSerializer
    end
  end
end
