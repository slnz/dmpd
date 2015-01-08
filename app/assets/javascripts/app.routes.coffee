app.config([ '$stateProvider', '$urlRouterProvider', '$locationProvider'
  ($stateProvider, $urlRouterProvider, $locationProvider)->
    $locationProvider.html5Mode true
    $urlRouterProvider
      .otherwise('/')
      .when(
        '/call_session/call/:id/input_contacts',
        '/call_session/call/:id/input_contacts/new',
      )
      .when(
        '/call_session/call/:id/appointment',
        '/call_session/call/:id/appointment/new',
      )
      .when(
        '/call_session/call/:id/callback',
        '/call_session/call/:id/callback/new',
      )
      .when(
        '/call_session/call/:id/support',
        '/call_session/call/:id/support/details',
      )
    $stateProvider
      .state('home',
        url: '/',
        templateUrl: 'home/index.html'
        controller: 'HomeController'
      )
      .state('contacts',
        url: '/contacts'
        templateUrl: 'contacts/status.html'
        controller: 'ContactsStatusController'
      )
      .state('contacts.list',
        url: '/state/:status'
        templateUrl: 'contacts/index.html'
        controller: 'ContactsIndexController'
      )
      .state('contacts.new',
        url: '/new'
        templateUrl: 'contacts/new.html'
        controller: 'ContactsNewController'
      )
      .state('contacts.show',
        url: '/:contactId'
        templateUrl: 'contacts/show.html'
        controller: 'ContactsShowController'
      )
      .state('appointments',
        url: '/appointments'
        templateUrl: 'appointments/index.html'
        controller: 'AppointmentsIndexController'
      )
      .state('contacts.show.appointments',
        url: '/appointments'
        templateUrl: 'contacts/appointments/base.html'
      )
      .state('contacts.show.appointments.index',
        url: '/'
        templateUrl: 'contacts/appointments/index.html'
        controller: 'ContactAppointmentsIndexController'
      )
      .state('contacts.show.appointments.new',
        url: '/new'
        templateUrl: 'contacts/appointments/new.html'
        controller: 'ContactAppointmentsNewController'
      )
      .state('contacts.show.appointments.show',
        url: '/:appointmentId'
        templateUrl: 'contacts/appointments/show.html'
        controller: 'ContactAppointmentsShowController'
      )
      .state('contacts.show.calls',
        url: '/calls'
        templateUrl: 'contacts/calls/base.html'
      )
      .state('contacts.show.calls.index',
        url: '/'
        templateUrl: 'contacts/calls/index.html'
        controller: 'ContactCallsIndexController'
      )
      .state('contacts.show.calls.show',
        url: '/:callId'
        templateUrl: 'contacts/calls/show.html'
        controller: 'ContactCallsShowController'
      )
      .state('calls',
        url: '/calls'
        templateUrl: 'calls/index.html'
        controller: 'CallsIndexController'
      )
      .state('contacts.show.callbacks',
        url: '/callbacks'
        templateUrl: 'callbacks/index.html'
        controller: 'CallbacksIndexController'
      )
      .state('contacts.show.callbacks.new',
        url: '/new'
        templateUrl: 'callbacks/new.html'
        controller: 'CallbacksNewController'
      )
      .state('contacts.show.callbacks.show',
        url: '/:callbackId'
        templateUrl: 'callbacks/show.html'
        controller: 'CallbacksShowController'
      )
      .state('logs',
        url: '/logs'
        templateUrl: 'logs/index.html'
        controller: 'LogsIndexController'
      )
      .state('call_session',
        url: '/call_session'
        templateUrl: 'call_session/show.html'
        controller: 'CallSessionShowController'
      )
      .state('call_session.new',
        url: '/new'
        templateUrl: 'call_session/new.html'
        controller: 'CallSessionNewController'
      )
      .state('call_session.call',
        url: '/call/:contactId'
        templateUrl: 'call/show.html'
        controller: 'CallShowController'
      )
      .state('call_session.call.start_call',
        url: '/start_call'
        templateUrl: 'call/start_call.html'
      )
      .state('call_session.call.busy',
        url: '/busy'
        templateUrl: 'call/busy.html'
      )
      .state('call_session.call.new_contact',
        url: '/new_contact'
        templateUrl: 'call/new_contact.html'
      )
      .state('call_session.call.must_callback_for_contacts',
        url: '/must_callback_for_contacts'
        templateUrl: 'call/must_callback_for_contacts.html'
      )
      .state('call_session.call.must_callback_for_decision',
        url: '/must_callback_for_decision'
        templateUrl: 'call/must_callback_for_decision.html'
      )
      .state('call_session.call.ask_for_contacts',
        url: '/ask_for_contacts'
        templateUrl: 'call/ask_for_contacts.html'
      )
      .state('call_session.call.appointment',
        url: '/appointment'
        templateUrl: 'call/appointment.html'
      )
      .state('call_session.call.appointment.new',
        url: '/new'
        templateUrl: 'contacts/appointments/new.html'
        controller: 'ContactAppointmentsNewController'
      )
      .state('call_session.call.callback',
        url: '/callback'
        templateUrl: 'call/callback.html'
      )
      .state('call_session.call.callback.new',
        url: '/new'
        templateUrl: 'callbacks/new.html'
        controller: 'CallbacksNewController'
      )
      .state('call_session.call.support',
        url: '/support'
        templateUrl: 'call/support.html'
      )
      .state('call_session.call.support.details',
        url: '/details'
        templateUrl: 'contacts/show.html'
        controller: 'ContactsShowController'
      )
      .state('call_session.call.not_present',
        url: '/not_present'
        templateUrl: 'call/not_present.html'
      )
      .state('call_session.call.input_contacts',
        url: '/input_contacts'
        templateUrl: 'call/input_contacts.html'
      )
      .state('call_session.call.input_contacts.new',
        url: '/new'
        templateUrl: 'contacts/new.html'
        controller: 'ContactsNewController'
      )
      .state('call_session.call.stats',
        url: '/stats'
        templateUrl: 'call/stats.html'
        controller: 'CallStatsController'
      )
      .state('call_session.call.end',
        url: '/end'
        templateUrl: 'call/end.html'
      )
])