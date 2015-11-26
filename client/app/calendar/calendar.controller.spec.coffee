'use strict'

describe 'Controller: CalendarCtrl', ->

  # load the controller's module
  beforeEach module 'fijiApp'
  CalendarCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    CalendarCtrl = $controller 'CalendarCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
