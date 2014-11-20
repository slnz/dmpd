app.factory('CallSession', ['$resource',
  ($resource)->
    $resource '/api/v1/call_session',
      {}
    ,
      end:
        method: 'GET'
        url: '/api/v1/call_session/end'
      data:
        method: 'GET'
        url: '/api/v1/call_session/data'
])