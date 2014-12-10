app.controller('CallsIndexController',
  [ '$scope', '$stateParams', 'Calls',
  ($scope, $stateParams, Calls)->
    $scope.calls = Calls.query()

    $scope.delete_call = (call) ->
      call.$delete()
      $scope.calls =
        _.without($scope.calls,
          _.findWhere($scope.calls, call))
])