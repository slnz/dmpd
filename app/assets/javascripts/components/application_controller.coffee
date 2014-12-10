app.controller('ApplicationController',
  [ '$rootScope', '$scope', '$state', 'Calls', 'CallSession',
  ($rootScope, $scope, $state, Calls, CallSession)->
    success = (response) ->
      $state.transitionTo('call_session.call', contactId: response.contact_id)
    Calls.latest(success)

    $rootScope.endSession = ->
      CallSession.delete({}, ->
        $state.go($state.current, {}, reload: true)
      )
])