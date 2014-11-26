import Ember from 'ember';

export default Ember.Route.extend({
  afterModel: function(paper, transition) {
    var promise;
    return promise = new Ember.RSVP.Promise(function(resolve, reject) {
      return Ember.$.ajax({
        method: 'GET',
        url: "/papers/" + (paper.get('id')) + "/manuscript_manager",
        success: function(json) {
          return Ember.run(null, resolve, json);
        },
        error: function(xhr, status, error) {
          return Ember.run(null, reject, xhr);
        }
      });
    });
  },
  setupController: function(controller, model) {
    controller.set('model', model);
    // controller.set('commentLooks', this.store.all('commentLook'));
    // return controller.set('canRemoveCard', true);
  },
  actions: {
    chooseNewCardTypeOverlay: function(phase) {
    },
    viewCard: function(task, queryParams) {
      var paper, redirectParams;
      queryParams = queryParams || (queryParams = { queryParams: {} });
      paper = this.modelFor('paper');
      redirectParams = ['paper.manage', this.modelFor('paper')];
      this.controllerFor('application').get('overlayRedirect').pushObject(redirectParams);
      this.controllerFor('application').set('overlayBackground', 'paper/manage');
      return this.transitionTo('task', paper.id, task.id, queryParams);
    },
    addTaskType: function(phase, taskType) {
    },
    showDeleteConfirm: function(task) {
    }
  }
});
