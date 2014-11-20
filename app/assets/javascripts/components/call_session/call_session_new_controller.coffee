app.controller('CallSessionNewController',
  ['$scope', '$resource', '$state', 'CallSession',
  ($scope, $resource, $state, CallSession)->
    $scope.data = CallSession.data()

    $scope.newCallSession = (id) ->
      if id
        newCallSession = new CallSession(
          call_session:
            partner_id: id
        )
      else
        newCallSession = new CallSession()
      newCallSession.$save({}, ->
        $state.go('call_session', {}, reload: true)
        )
])