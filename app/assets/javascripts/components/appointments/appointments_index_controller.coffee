app.controller('AppointmentsIndexController',
  [ '$scope', '$resource', '$stateParams', 'Contact', 'Appointment',
  ($scope, $resource, $stateParams, Contact, Appointment)->
    $scope.appointments = Appointment.query(
      contactId: $stateParams['contactId']
    )
])