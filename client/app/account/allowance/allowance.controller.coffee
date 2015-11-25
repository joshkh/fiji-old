'use strict'

angular.module 'fijiApp'
.controller 'AllowanceCtrl', ($scope, $http, Auth) ->

  $scope.$watch 'datePicker', (val) -> null
