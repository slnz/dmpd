app.controller('ContactCallsIndexController',
  [ '$scope', '$resource', '$stateParams', 'Contact', 'Calls',
  ($scope, $resource, $stateParams, Contact, Calls)->
    $scope.contact = $scope.$parent.contact
    $scope.calls = Calls.query(
      contact_id: $stateParams['contactId']
    )

    $scope.delete_call = (call) ->
      call.$delete(contactId: $stateParams['contactId'])
      $scope.calls =
        _.without($scope.calls,
          _.findWhere($scope.calls, call))
])