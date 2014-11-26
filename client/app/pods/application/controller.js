import Ember from 'ember';

export default Ember.Controller.extend({
  canViewAdminLinks: false,
  canViewFlowManagerLink: false,

  actions: {
    toggleNavigation: function() {
      this.toggleProperty('navigationVisible');

      if(this.get('navigationVisible')) {
        $('html').addClass('navigation-visible');
      }
      else {
        $('html').removeClass('navigation-visible');
      }
    },

    routeTo: function(routeName) {
      this.send('toggleNavigation');
      this.set('accountLinksVisible', false);
      this.transitionToRoute(routeName);
    }
  }
});
