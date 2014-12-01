`import Ember from 'ember';`
`import DS from 'ember-data';`

a = DS.attr

User = DS.Model.extend

  affiliations: DS.hasMany('affiliation')

  siteAdmin: a('boolean')
  email: a('string')
  fullName: a('string')
  firstName: a('string')
  avatarUrl: a('string')
  username: a('string')

  name: Ember.computed.alias('fullName')
  affiliationsByDate: Ember.computed.sort('affiliations', 'affiliationSort')
  affiliationSort: ['isCurrent:desc', 'endDate:desc', 'startDate:asc']

`export default User;`
