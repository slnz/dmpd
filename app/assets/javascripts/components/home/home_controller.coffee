app.controller('HomeController', [ '$scope', 'Log' ,
  ($scope, Log)->
    $scope.latest = Log.latest()
])