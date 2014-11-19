app.controller('CallbacksNewController',
  [ '$rootScope', '$scope', '$resource', '$stateParams', 'Callback',
  ($rootScope, $scope, $resource, $stateParams, Callback)->
    $scope.callback = new Callback

    failure = (response) ->
      _.each response.data, (errors, key) ->
        _.each errors, (e) ->
          return unless $scope.form[key]?
          $scope.form[key].$dirty = true
          $scope.form[key].$setValidity e, false

    success = ->
      angular.copy($scope.callback, $scope.initial)
      $scope.form.$setPristine()

    $scope.createCallback = ->
      if $scope.callback.id?
        $scope.callback.$update(
          contactId: $stateParams['contactId']
          ,
          success,
          failure)
      else
        $scope.callback.$create(
          contactId: $stateParams['contactId']
          ,
          success,
          failure)

    $scope.errorClass = (name) ->
      s = $scope.form[name]
      return unless s?
      s.$invalid && s.$dirty ? 'error' : ''

    $scope.errorMessage = (name) ->
      result = []
      _.each $scope.form[name].$error, (key, value) ->
        result.push value
        return
      result.join ', '

    $scope.reset = ->
      angular.copy($scope.initial, $scope.callback)
      $scope.form.$setPristine()

    $scope.reset_to_new = ->
      $scope.callback = new Callback
      angular.copy($scope.callback, $scope.initial)
      $scope.form.$setPristine()

    Callback.query((response) ->
      $scope.referers = response
    )
])