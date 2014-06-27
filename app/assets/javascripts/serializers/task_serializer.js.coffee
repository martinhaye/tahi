ETahi.TaskSerializer = ETahi.ApplicationSerializer.extend ETahi.SerializesHasMany,
  serializeIntoHash: (data, type, record, options) ->
    root = 'task'
    data[root] = this.serialize(record, options)

  primaryTypeName: (primaryType) ->
    'task'

ETahi.PaperReviewersTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.PaperEditorTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.PaperAdminTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.AuthorsTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.MessageTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.TechCheckTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.RegisterDecisionTaskSerializer = ETahi.TaskSerializer.extend()
ETahi.ReviewerReportTaskSerializer = ETahi.TaskSerializer.extend()
