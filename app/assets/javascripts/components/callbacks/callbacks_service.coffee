app.factory('Callback', ['$resource',
  ($resource)->
    $resource '/api/v1/contacts/:contactId/return_calls/:id',
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