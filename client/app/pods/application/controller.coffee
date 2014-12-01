`import Ember from 'ember'`

ApplicationController = Ember.Controller.extend

  canViewAdminLinks: false
  canViewFlowManagerLink: false

  actions:
    toggleNavigation: ->
      @toggleProperty('navigationVisible')

      if @get('navigationVisible')
        $('html').addClass('navigation-visible')
      else
        $('html').removeClass('navigation-visible')

    routeTo: (routeName) ->
      @send('toggleNavigation')
      @set('accountLinksVisible', false)
      @transitionToRoute(routeName)

`export default ApplicationController`
