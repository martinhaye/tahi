ETahi.JournalTaskTypeController = Em.ObjectController.extend
  needs: ['journal']
  journal: Ember.computed.alias('controllers.journal')
  journalRoleSort: ['name: asc']
  availableTaskRoles: Ember.computed.sort('journal.roles', 'journalRoleSort')
  actions:
    save: ->
      @get('model').save().then(
      ).catch -> # ignore 422. we're displaying errors

    cancel: ->
      if @get('model.isNew')
        @get('model').deleteRecord()
      else
        @get('model').rollback()

    delete: ->
      @send('deleteRole', @get('model'))
