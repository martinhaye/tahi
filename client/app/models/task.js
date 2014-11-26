import Ember from 'ember';
import DS from 'ember-data';

var a = DS.attr;

export default DS.Model.extend({
  phase: DS.belongsTo('phase'),
  // attachments: DS.hasMany('attachment'),
  // comments: DS.hasMany('comment'),
  // participations: DS.hasMany('participation'),
  body: a(),
  completed: a('boolean'),
  paperTitle: a('string'),
  role: a('string'),
  title: a('string'),
  type: a('string'),
  qualifiedType: a('string'),
  isMetadataTask: false,
  paper: DS.belongsTo('paper')
  // litePaper: DS.belongsTo('litePaper'),
  // cardThumbnail: DS.belongsTo('cardThumbnail', {
  //   inverse: 'task'
  // }),
  // questions: DS.hasMany('question', {
  //   inverse: 'task'
  // })
});
