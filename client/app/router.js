import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.route('index', { path: '/' });
  this.route('login', { path: '/login' });

  this.resource('paper', { path: '/papers/:paper_id' }, function() {
    this.route('manage');
  });
});

export default Router;
