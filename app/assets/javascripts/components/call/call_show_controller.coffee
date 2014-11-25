app.controller('CallShowController',
  ['$rootScope', '$scope', '$resource', '$state',
   '$stateParams', 'CallSession', 'Contact', 'Call', 'storage'
  ($rootScope, $scope, $resource, $state, $stateParams,
  CallSession, Contact, Call, storage) ->
    storage.bind($scope, 'media')
    $scope.activeCamera = false
    $scope.contact = Contact.get(id: $stateParams['contactId'])
    $scope.call = Call.fetch(contactId: $stateParams['contactId'], (response) ->
      $state.go('call_session.call.' + response.step)
    )
    $scope.update_call = (step, state) ->
      Call.get(contactId: $stateParams['contactId'],
        id: step,
        state: state, (response) ->
          $state.go('call_session.call.' + response.step)
      )
    $scope.remove_active_contact = ->
      $scope.$parent.contacts =
        _.without($scope.$parent.contacts,
          _.findWhere($scope.$parent.contacts, $scope.$parent.expanded))
])