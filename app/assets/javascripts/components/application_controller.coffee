app.controller('ApplicationController',
  [ '$rootScope', '$scope', '$state', 'Call', 'CallSession',
  ($rootScope, $scope, $state, Call, CallSession)->
    success = (response) ->
      $state.transitionTo('call_session.call', contactId: response.contact_id)
    Call.latest(success)

    $rootScope.endSession = ->
      CallSession.delete({}, ->
        $state.go($state.current, {}, reload: true)
      )
])