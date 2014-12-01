`import DS from 'ember-data'`

a = DS.attr

CardThumbnail = DS.Model.extend

  litePaper: DS.belongsTo('litePaper')
  task: DS.belongsTo('task', polymorphic: true)

  title: a('string')
  taskType: a('string')
  completed: a('boolean')
  position: a('number')

`export default CardThumbnail`
