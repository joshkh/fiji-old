'use strict'

angular.module 'fijiApp'
.controller 'AllowanceCtrl', ($scope, $http, Auth, User) ->


  $scope.getCurrentUser = Auth.getCurrentUser

  # $scope.datePicker = {todayHighlight: true}

  user = Auth.getCurrentUser();


  $scope.friendlydate = (date) ->
    moment(date).format("DD MMM, YYYY")



  $scope.$watch 'datePicker', (val) ->
    if val
      if val.startDate.toString() == val.endDate.toString()
        $scope.singleday = true


  getAllowance = ->
    $http.get('/api/allowances/' + user.email).then (success) ->
      # debugger
      $scope.absences = success.data
    , (failure) -> null

  getAbsences = ->
    $http.get('/api/absences').then (success) ->
      $scope.absences = success.data
      # debugger
    , (failure) -> null

  $scope.getStats = ->
    $http.get('/api/absences/test/2015').then (success) ->
      # $scope.absences = success.data
      debugger
    , (failure) -> null
  $scope.talk = ->

    # debugger

    payload =
      from: $scope.datePicker.startDate.toDate()
      to: $scope.datePicker.endDate.toDate()
      comment: $scope.comment
      reason: $scope.reason

    currentUser = Auth.getCurrentUser()

    $http.post('/api/absences', payload).then (success) ->
      getAbsences()
    , (failure) -> null

  $scope.delete = (absence) ->
    # debugger
    $http.delete('/api/absences/' + absence._id).then (success) ->
      debugger
      getAbsences()
    , (failure) -> debugger


  getAllowance()
  getAbsences()
