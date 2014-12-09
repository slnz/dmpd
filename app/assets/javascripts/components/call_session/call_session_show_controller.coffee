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
      $scope.expanded_index = null
    failure = (response) ->
      $scope.validCallSession = false
      $state.go('call_session.new')

    $scope.callSession = CallSession.get({}, success, failure)

    $scope.expand = (contact, index) ->
      $scope.expanded = contact
      $scope.expanded_index = index

    $scope.update_contact = (contact) ->
      if contact.category == 'base' || contact.category == 'callback'
        $scope.contacts[$scope.expanded_index] = contact
      else
        $scope.contacts =
          _.without($scope.contacts,
            _.findWhere($scope.contacts, $scope.expanded))
      $scope.expand(null, null)

    $rootScope.endSession = ->
      CallSession.delete({}, ->
        $state.go($state.current, {}, reload: true)
      )
])