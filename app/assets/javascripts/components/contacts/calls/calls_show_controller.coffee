app.controller('ContactCallsShowController',
  [ '$rootScope', '$scope', '$resource', '$stateParams', 'Calls',
  ($rootScope, $scope, $resource, $stateParams, Calls)->
    $scope.contact = $scope.$parent.contact
    $scope.call = Calls.get(id: $stateParams['callId'])
])