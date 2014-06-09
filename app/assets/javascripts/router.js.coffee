# For more information see: http://emberjs.com/guides/routing/
ETahi.Router.map ()->
  @route('flow_manager')
  @resource 'paper', { path: '/papers/:paper_id' }, ->
    @route('edit')
    @route('manage')
    @route('submit')

  @route('task', {path: '/papers/:paper_id/tasks/:task_id'})
  @route('paper_new', { path: '/papers/new' })
  @route('signin', {path: '/users/sign_in'})
  @route('signup', {path: '/users/sign_up'})
  @route('profile', {path: '/profile'})

  @resource('affiliation')
  @resource('author')

  @resource 'admin', ->
    @resource 'journal', path: '/journals/:journal_id', ->
      @resource 'manuscript_manager_template', path: '/manuscript_manager_templates', ->
        @route('new')
        @route('edit', path: '/:template_id/edit')

if window.history and window.history.pushState
  ETahi.Router.reopen
    rootURL: '/'
    location: 'history'
