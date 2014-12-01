`import Task from 'tahi/models/task'`

PlosAuthorsTask = Task.extend

  plosAuthors: DS.hasMany('plosAuthor')

  qualifiedType: "StandardTasks::PlosAuthorsTask"
  isMetadataTask: true

`export default PlosAuthorsTask`
