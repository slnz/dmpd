app.factory('Calls', ['$resource',
  ($resource)->
    $resource '/api/v1/calls/:id',
      id: '@id'
    ,
      query:
        method: 'GET'
        isArray: true
      update:
        method: 'PUT'
      latest:
        method: 'GET'
        url: '/api/v1/calls/latest'
])