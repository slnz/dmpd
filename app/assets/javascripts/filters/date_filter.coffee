app.filter 'dateFilter', ['$filter', ($filter) ->
  (input, format) ->
    return '' unless input?
    $filter('date')(new Date(input), format)
]