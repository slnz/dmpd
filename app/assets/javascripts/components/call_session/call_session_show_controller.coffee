app.controller('CallSessionShowController',
  ['$rootScope', '$scope', '$resource', '$state', 'CallSession', 'Contact',
  ($rootScope, $scope, $resource, $state, CallSession, Contact)->
    success = (response) ->
      $scope.validCallSession = true
      $scope.start_time = new Date(0)
      $scope.start_time.setUTCSeconds(response.start_time)
      $scope.contacts =
        Contact.query(calls: true, 'q[s]': 'first_name')
      $rootScope.add_topbar_call_session(response)
      $scope.search = ''
      $scope.expanded = null
    failure = (response) ->
      $scope.validCallSession = false
      $state.go('call_session.new')

    $scope.callSession = CallSession.get({}, success, failure)

    $scope.expand = (id) ->
      $scope.expanded = id

    $rootScope.endSession = ->
      CallSession.delete({}, ->
        $state.go($state.current, {}, reload: true)
      )
])