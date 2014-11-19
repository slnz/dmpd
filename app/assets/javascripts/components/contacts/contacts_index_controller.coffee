app.controller('ContactsIndexController',
  [ '$scope', '$resource', '$stateParams', 'Contact', 'ngTableParams',
  ($scope, $resource, $stateParams, Contact, ngTableParams)->
    requestParams = {}
    requestParams[$stateParams.status] = true
    $scope.tableParams = new ngTableParams(
      page: 1
      count: 25
    ,
      getData: ($defer, params) ->
        requestParams['page'] = params.page()
        requestParams['limit'] = params.count()
        requestParams['q[s]'] = 'first_name'
        Contact.query(requestParams, (contacts) ->
          params.total(contacts[0].total)
          $defer.resolve contacts
        )
    )
])