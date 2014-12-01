`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

PapersRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @store.find('paper', params.paper_id)

`export default PapersRoute`
