app.controller('ContactsStatusController', [ '$scope', '$resource', 'Contact'
  ($scope, $resource, Contact)->
    $scope.statuses = Contact.status()
])