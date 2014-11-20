app.controller('ContactsNewController',
  [ '$rootScope', '$scope', '$resource', '$stateParams', 'Contact',
  ($rootScope, $scope, $resource, $stateParams, Contact)->
    $scope.contact = new Contact

    failure = (response) ->
      _.each response.data, (errors, key) ->
        _.each errors, (e) ->
          return unless $scope.form[key]?
          $scope.form[key].$dirty = true
          $scope.form[key].$setValidity e, false

    success = ->
      angular.copy($scope.contact, $scope.initial)
      $scope.form.$setPristine()

    $scope.createContact = ->
      if $scope.contact.id?
        $scope.contact.$update(success, failure)
      else
        $scope.contact.$create(success, failure)

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

    $scope.reset_to_new = ->
      $scope.contact = new Contact
      angular.copy($scope.contact, $scope.initial)
      $scope.form.$setPristine()

    Contact.query((response) ->
      $scope.referers = response
    )
])