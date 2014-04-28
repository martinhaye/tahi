ETahi.FlowManagerRoute = Ember.Route.extend
  beforeModel: (transition)->
    unless Tahi.currentUser.admin
      transition.abort()
      @transitionTo('index')

  model: ->
    @store.find('flow')

  actions:
    chooseNewFlowMangerColumn: ->
      @render('chooseNewFlowManagerColumnOverlay',
        into: 'application'
        outlet: 'overlay'
        controller: 'chooseNewFlowManagerColumnOverlay')

    removeFlow: (flow) ->
      flow.destroyRecord()

    viewCard: (paper, task) ->
      redirectParams = ['flow_manager']
      @controllerFor('application').set('overlayRedirect', redirectParams)
      @controllerFor('application').set('overlayBackground', 'flow_manager')
      @transitionTo('paper.task', paper.id, task.id)
