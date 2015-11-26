'use strict'

angular.module 'fijiApp'
.controller 'AllowanceCtrl', ($scope, $http, Auth) ->


  $scope.getCurrentUser = Auth.getCurrentUser

  # $scope.datePicker = {todayHighlight: true}

  user = Auth.getCurrentUser();
  debugger


  $scope.friendlydate = (date) ->
    moment(date).format("DD MMM, YYYY")



  $scope.$watch 'datePicker', (val) -> null

  getAllowance = ->
    $http.get('/api/allowances/' + user.email).then (success) ->
      debugger
      $scope.absences = success.data
    , (failure) -> null

  getAbsences = ->
    $http.get('/api/absences').then (success) ->
      $scope.absences = success.data
    , (failure) -> null

  $scope.talk = ->

    debugger

    payload =
      from: $scope.datePicker.startDate.toDate()
      to: $scope.datePicker.endDate.toDate()
      comment: $scope.comment
      reason: $scope.reason

    currentUser = Auth.getCurrentUser()

    $http.post('/api/absences', payload).then (success) ->
      getAbsences()
    , (failure) -> null


  getAllowance()
  getAbsences()
