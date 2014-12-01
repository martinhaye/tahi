`import DS from 'ember-data'`

a = DS.attr

Question = DS.Model.extend

  task: DS.belongsTo('task', polymorphic: true, inverse: 'questions')
  questionAttachment: DS.belongsTo('questionAttachment')

  ident: a('string')
  question: a('string')
  answer: a('string')
  additionalData: a()
  url: a('string')

`export default Question`
