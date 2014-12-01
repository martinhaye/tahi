`import DS from 'ember-data'`

a = DS.attr

PlosAuthor = DS.Model.extend

  paper: DS.belongsTo('paper')
  plosAuthorsTask: DS.belongsTo('plosAuthorsTask')
  qualifiedType: "PlosAuthors::PlosAuthor"

  firstName: a('string')
  middleInitial: a('string')
  lastName: a('string')
  email: a('string')
  title: a('string')
  department: a('string')
  affiliation: a('string')
  secondaryAffiliation: a('string')
  corresponding: a('boolean')
  deceased: a('boolean')
  position: a('number')

  fullName: (->
    [@get('firstName'), @get('middleInitial'), @get('lastName')].compact().join(' ')
  ).property('firstName', 'middleInitial', 'lastName')

`export default PlosAuthor`
