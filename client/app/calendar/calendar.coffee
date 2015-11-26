'use strict'

angular.module 'fijiApp'
.config ($stateProvider) ->
  $stateProvider.state 'calendar',
    url: '/calendar'
    templateUrl: 'app/calendar/calendar.html'
    controller: 'CalendarCtrl'
