app.controller('CallbacksIndexController',
  [ '$scope', '$resource', '$stateParams', 'Contact', 'Callback',
  ($scope, $resource, $stateParams, Contact, Callback)->
    $scope.callbacks = Callback.query(
      contactId: $stateParams['contactId']
    )
])