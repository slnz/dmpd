app.controller('CallStatsController',
  ['$scope', '$stateParams', 'Call', ($scope, $stateParams, Call) ->
    $scope.update_call = $scope.$parent.update_call
    $scope.call = Call.fetch(contactId: $stateParams['contactId'])
])