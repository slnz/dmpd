app.controller('ContactsShowController',
  [ '$rootScope', '$scope', '$resource', '$stateParams', '$state', 'Contact',
  ($rootScope, $scope, $resource, $stateParams, $state, Contact)->
    $scope.contact = Contact.get(id: $stateParams['contactId'], ->
       $scope.initial = angular.copy($scope.contact)
    )
    $rootScope.add_topbar_contact $stateParams['contactId'], $scope.contact
    failure = (response) ->
      _.each response.data, (errors, key) ->
        _.each errors, (e) ->
          $scope.form[key].$dirty = true
          $scope.form[key].$setValidity e, false

    success = ->
      angular.copy($scope.contact, $scope.initial)
      $scope.form.$setPristine()

    $scope.updateContact = ->
      $scope.contact.$update(success, failure)

    $scope.errorClass = (name) ->
      s = $scope.form[name]
      s.$invalid && s.$dirty ? 'error' : ''

    $scope.errorMessage = (name) ->
      result = []
      _.each $scope.form[name].$error, (key, value) ->
        result.push value
        return
      result.join ', '

    $scope.reset = ->
      angular.copy($scope.initial, $scope.contact)
      $scope.form.$setPristine()

    Contact.query((response) ->
      $scope.referers = response
    )

    $scope.$state = $state
])