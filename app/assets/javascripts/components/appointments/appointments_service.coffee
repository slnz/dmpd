app.factory('Appointment', ['$resource',
  ($resource)->
    $resource '/api/v1/contacts/:contactId/appointments/:id',
      id: '@id'
    ,
      query:
        method: 'GET'
        isArray: true
      create:
        method: 'POST'
      update:
        method: 'PUT'
])