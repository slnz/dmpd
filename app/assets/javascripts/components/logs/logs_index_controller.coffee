app.controller('LogsIndexController',
  [ '$scope', '$stateParams', 'Log',
  ($scope, $stateParams, Log)->
    $scope.logs = Log.query()
])