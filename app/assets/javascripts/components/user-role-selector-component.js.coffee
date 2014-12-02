ETahi.UserRoleSelectorComponent = Ember.Component.extend
  classNames: ['user-role-selector', 'select2-multiple']

  actions:
    assignRole: (data) ->
      @sendAction("selected", data)
    removeRole: (data) ->
      @sendAction("removed", data)
    dropdownClosed: ->
      @$('.select2-search-field input').removeClass('active')
      @$('.add-participant-button').removeClass('searching')
    activateDropdown: ->
      @$('.select2-search-field input').addClass('active').trigger('click')
      @$('.add-participant-button').addClass('searching')
