'use strict'

describe 'Controller: AllowanceCtrl', ->

  # load the controller's module
  beforeEach module 'fijiApp'
  AllowanceCtrl = undefined
  scope = undefined

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AllowanceCtrl = $controller 'AllowanceCtrl',
      $scope: scope

  it 'should ...', ->
    expect(1).toEqual 1
