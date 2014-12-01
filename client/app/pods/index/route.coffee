`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

IndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: ->
    @store.find('dashboard')

`export default IndexRoute`
