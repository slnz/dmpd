app.controller('AppointmentsIndexController',
  [ '$scope', '$resource', '$stateParams', 'Contact', 'Appointment',
  ($scope, $resource, $stateParams, Contact, Appointment)->
    $scope.contact = $scope.$parent.contact
    $scope.appointments = Appointment.query()
    $scope.future = (time) ->
      return false unless time?
      new Date < new Date(time)
])