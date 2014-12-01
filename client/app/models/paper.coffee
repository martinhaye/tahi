`import DS from 'ember-data'`

a = DS.attr

Paper = DS.Model.extend

  editors: DS.hasMany('user')
  reviewers: DS.hasMany('user')
  authors: DS.hasMany('author')
  figures: DS.hasMany('figure', inverse: 'paper')
  # supportingInformationFiles: DS.hasMany('supportingInformationFile')
  phases: DS.hasMany('phase')
  tasks: DS.hasMany('task', async: true, polymorphic: true)
  journal: DS.belongsTo('journal')
  lockedBy: DS.belongsTo('user')

  body: a('string')
  doi: a('string')
  shortTitle: a('string')
  submitted: a('boolean')
  status: a('string')
  title: a('string')
  paperType: a('string')
  eventName: a('string')
  strikingImageId: a('string')
  editable: a('boolean')

  relationshipsToSerialize: []
  allMetadataTasksCompleted: false

  collaborators: (->
    @get('collaborations').mapBy('user')
  ).property('collaborations.@each')

  displayTitle: (->
    @get('title') || @get('shortTitle')
  ).property('title', 'shortTitle')

  allMetadataTasks: (->
    @get('tasks').filterBy('isMetadataTask')
  ).property('tasks.content.@each.isMetadataTask')

  unloadRecord: ->
    litePaper = @store.getById('litePaper', @get('id'))
    if litePaper
      @store.unloadRecord(litePaper)
    @_super()

`export default Paper`
