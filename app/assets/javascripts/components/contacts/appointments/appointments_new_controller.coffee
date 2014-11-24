app.controller('ContactAppointmentsNewController',
  [ '$rootScope', '$scope', '$resource', '$stateParams', 'ContactAppointment',
  ($rootScope, $scope, $resource, $stateParams, Appointment)->
    $scope.appointment = new Appointment

    failure = (response) ->
      _.each response.data, (errors, key) ->
        _.each errors, (e) ->
          return unless $scope.form[key]?
          $scope.form[key].$dirty = true
          $scope.form[key].$setValidity e, false

    success = ->
      angular.copy($scope.appointment, $scope.initial)
      $scope.form.$setPristine()

    $scope.createAppointment = ->
      if $scope.appointment.id?
        $scope.appointment.$update(
          contactId: $stateParams['contactId']
          ,
          success,
          failure)
      else
        $scope.appointment.$create(
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
      angular.copy($scope.initial, $scope.appointment)
      $scope.form.$setPristine()

    $scope.reset_to_new = ->
      $scope.appointment = new Appointment
      angular.copy($scope.appointment, $scope.initial)
      $scope.form.$setPristine()

    Appointment.query((response) ->
      $scope.referers = response
    )
])