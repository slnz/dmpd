app.factory('Call', ['$resource',
  ($resource)->
    $resource '/api/v1/contacts/:contactId/calls/:id',
      id: '@id',
      state: '@state'
    ,
      fetch:
        method: 'GET'
        url: '/api/v1/contacts/:contactId/calls/fetch'
])