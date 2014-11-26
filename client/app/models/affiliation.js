import Ember from 'ember';
import DS from 'ember-data';

var a = DS.attr;

export default DS.Model.extend({
  user: DS.belongsTo('user'),
  name: a('string'),
  endDate: a('string'),
  startDate: a('string'),
  email: a('string'),
  isCurrent: (function() {
    return Ember.isBlank(this.get('endDate'));
  }).property('endDate'),
  displayEndDate: (function() {
    return this.get('endDate') || "Current";
  }).property('endDate')
});
