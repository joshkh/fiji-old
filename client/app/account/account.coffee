'use strict'

angular.module 'fijiApp'
.config ($stateProvider) ->
  $stateProvider
  .state 'login',
    url: '/login'
    templateUrl: 'app/account/login/login.html'
    controller: 'LoginCtrl'

  .state 'signup',
    url: '/signup'
    templateUrl: 'app/account/signup/signup.html'
    controller: 'SignupCtrl'

  .state 'settings',
    url: '/settings'
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'
    authenticate: true

  .state 'allowance',
    url: '/allowance'
    templateUrl: 'app/account/allowance/allowance.html'
    controller: 'AllowanceCtrl'
    authenticate: true
