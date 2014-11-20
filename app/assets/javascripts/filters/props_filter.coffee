app.filter 'propsFilter', ->
  (items, props) ->
    out = []
    return items unless angular.isArray(items)
    items.forEach (item) ->
      itemMatches = false
      keys = Object.keys(props)
      i = 0
      while i < keys.length
        prop = keys[i]
        text = props[prop].toLowerCase()
        if item[prop].toString().toLowerCase().indexOf(text) isnt -1
          itemMatches = true
          break
        i++
      out.push item if itemMatches
    return out
