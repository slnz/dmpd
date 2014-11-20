window.app = angular.module('dmpd',[
  'templates',
  'ui.router',
  'ngResource',
  'ngTable',
  'ui.select',
  'ngSanitize',
  'ngAnimate',
  'angularMoment',
  'omr.directives',
  'angularLocalStorage',
  'ngCookies',
  'ui.bootstrap.datetimepicker',
  'ui.bootstrap'
])

app.config ($httpProvider) ->
  authToken =
    document.getElementsByTagName('meta')['csrf-token'].getAttribute('content')
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken