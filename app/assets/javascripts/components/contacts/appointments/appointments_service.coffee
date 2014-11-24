app.factory('ContactAppointment', ['$resource',
  ($resource)->
    $resource '/api/v1/contacts/:contactId/appointments/:id',
      id: '@id'
      state: '@state'
    ,
      query:
        method: 'GET'
        isArray: true
      create:
        method: 'POST'
      update:
        method: 'PUT'
])