ETahi.PaperManageRoute = ETahi.AuthorizedRoute.extend
  afterModel: (paper, transition) ->
    # Ping manuscript_manager url for authorization
    promise = new Ember.RSVP.Promise (resolve, reject) ->
      Ember.$.ajax
        method:  'GET'
        url:     "/papers/#{paper.get('id')}/manuscript_manager"
        success: (json) -> Ember.run(null, resolve, json)
        error:   (xhr, status, error) -> Ember.run(null, reject, xhr)

  actions:
    viewCard: (task) ->
      paper = @modelFor('paper')
      redirectParams = ['paper.manage', @modelFor('paper')]
      @controllerFor('application').get('overlayRedirect').pushObject(redirectParams)
      @controllerFor('application').set('overlayBackground', 'paper/manage')
      @transitionTo('task', paper.id, task.id)
