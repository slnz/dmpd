app.factory('Appointment', ['$resource',
  ($resource)->
    $resource '/api/v1/appointments/:id',
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