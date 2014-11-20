app.factory('Contact', ['$resource',
  ($resource)->
    $resource '/api/v1/contacts/:id',
      id: '@id'
    ,
      create:
        method: 'POST'
      update:
        method: 'PUT'
      status:
        method: 'GET'
        url: '/api/v1/contacts/status'
        isArray: true
])