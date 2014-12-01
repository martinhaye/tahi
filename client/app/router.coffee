`import Ember from 'ember'`
`import config from './config/environment'`

Router = Ember.Router.extend
  location: config.locationType

Router.map ->
  @route('index', path: '/')
  @route('login', path: '/login')

  @resource 'paper', path: '/papers/:paper_id', ->
    @route('manage')

`export default Router`
