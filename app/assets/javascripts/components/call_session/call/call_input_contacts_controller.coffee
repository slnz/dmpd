app.controller('CallInputContactsController',
  ['$rootScope', '$scope', '$state', '$stateParams',
  ($rootScope, $scope, $state, $stateParams) ->
    $scope.update_call = $scope.$parent.update_call
])