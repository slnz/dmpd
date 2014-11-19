app.controller('TopbarController',
  ['$rootScope', '$scope', '$state', '$stateParams', '$location', 'CallSession',
  ($rootScope, $scope, $state, $stateParams, $location, CallSession)->
    $scope.contacts = {}
    $scope.callSession = CallSession.get()

    $rootScope.add_topbar_contact = (id, contact) ->
      $scope.contacts[id] = contact

    $rootScope.add_topbar_call_session = (callSession) ->
      $scope.callSession = callSession

    $rootScope.current_user = window.current_user

    $scope.closeTab = (id) ->
      delete $scope.contacts[id]
      $state.go('contacts') if $stateParams['id'] == id

    $scope.endSession = ->
      $scope.callSession = {}
      $rootScope.endSession()

])