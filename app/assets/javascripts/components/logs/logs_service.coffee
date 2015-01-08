app.factory('Log', ['$resource',
  ($resource)->
    $resource '/api/v1/logs/:id',
      id: '@id'
    ,
      create:
        method: 'POST'
      update:
        method: 'PUT'
      latest:
        method: 'GET'
        url: '/api/v1/logs/latest'
])