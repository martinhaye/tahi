`import Ember from 'ember';`
`import DS from 'ember-data';`

a = DS.attr

Task = DS.Model.extend
  phase: DS.belongsTo('phase')
  attachments: DS.hasMany('attachment')
  comments: DS.hasMany('comment')
  participations: DS.hasMany('participation')
  paper: DS.belongsTo('paper')
  litePaper: DS.belongsTo('litePaper')
  cardThumbnail: DS.belongsTo('cardThumbnail', { inverse: 'task' })
  questions: DS.hasMany('question', { inverse: 'task' })

  body: a()
  completed: a('boolean')
  paperTitle: a('string')
  role: a('string')
  title: a('string')
  type: a('string')
  qualifiedType: a('string')

  isMetadataTask: false

`export default Task;`
