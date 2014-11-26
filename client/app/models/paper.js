import DS from 'ember-data';

var a = DS.attr;

export default DS.Model.extend({
  editors: DS.hasMany('user'),
  reviewers: DS.hasMany('user'),
  // collaborators: (function() {
  //   return this.get('collaborations').mapBy('user');
  // }).property('collaborations.@each'),
  // authors: DS.hasMany('author'),
  // figures: DS.hasMany('figure', {
  //   inverse: 'paper'
  // }),
  // supportingInformationFiles: DS.hasMany('supportingInformationFile'),
  // journal: DS.belongsTo('journal'),
  // phases: DS.hasMany('phase'),
  tasks: DS.hasMany('task', {
    async: true,
    polymorphic: true
  }),
  // lockedBy: DS.belongsTo('user'),
  body: a('string'),
  doi: a('string'),
  shortTitle: a('string'),
  submitted: a('boolean'),
  status: a('string'),
  title: a('string'),
  paperType: a('string'),
  eventName: a('string'),
  strikingImageId: a('string'),
  editable: a('boolean'),
  relationshipsToSerialize: [],
  displayTitle: (function() {
    return this.get('title') || this.get('shortTitle');
  }).property('title', 'shortTitle'),
  allMetadataTasks: (function() {
    return this.get('tasks').filterBy('isMetadataTask');
  }).property('tasks.content.@each.isMetadataTask'),
  allMetadataTasksCompleted: false,
  unloadRecord: function() {
    var litePaper;
    litePaper = this.store.getById('litePaper', this.get('id'));
    if (litePaper) {
      this.store.unloadRecord(litePaper);
    }
    return this._super();
  }
});
