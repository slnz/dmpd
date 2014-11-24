app.controller('ContactAppointmentsIndexController',
  [ '$scope', '$resource', '$stateParams', 'Contact', 'ContactAppointment',
  ($scope, $resource, $stateParams, Contact, Appointment)->
    $scope.contact = $scope.$parent.contact
    $scope.appointments = Appointment.query(
      contactId: $stateParams['contactId']
    )
    $scope.future = (time) ->
      return false unless time?
      new Date < new Date(time)
])