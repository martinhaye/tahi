/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'tahi',
    environment: environment,
    podModulePrefix: 'tahi/pods',
    baseURL: '/',
    locationType: 'auto',

    'simple-auth-devise': {
      resourceName: 'user',
      authorizer: 'simple-auth-authorizer:devise',
      crossOriginWhitelist: ['http://localhost:5000'],
      serverTokenEndpoint: 'http://localhost:5000/users/sign_in',
      store: 'simple-auth-session-store:local-storage'
    },

    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  ENV.contentSecurityPolicy = {
    'default-src': "'none'",
    // 'script-src': "'self' 'unsafe-eval'",
    'font-src': "'self' http://fonts.gstatic.com", // Allow fonts to be loaded from http://fonts.gstatic.com
    'connect-src': "'self' http://localhost:5000", // Allow data (ajax/websocket) from api.mixpanel.com and custom-api.local
    'img-src': "'self'",
    'style-src': "'self' 'unsafe-inline'", // Allow inline styles and loaded CSS from http://fonts.googleapis.com 
    'media-src': "'self'"
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    ENV.APP.LOG_VIEW_LOOKUPS = true;
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {

  }

  return ENV;
};
