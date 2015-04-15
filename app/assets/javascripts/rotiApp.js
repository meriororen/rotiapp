var rotiApp = angular.module('rotiApp', ['ngRoute', 'ngResource', 'ui.bootstrap']);

rotiApp.config(function($routeProvider, $locationProvider) {
  $routeProvider.when('/', { redirectTo: '/dashboard' });
  $routeProvider.when('/dashboard', { templateUrl: '/templates/dashboard.html', controller: 'DashboardController' });
  $routeProvider.when('/rotis', { templateUrl: '/templates/roti.html', controller: 'RotiController' });
  $routeProvider.when('/lokasis', { templateUrl: '/templates/lokasi.html', controller: 'LokasiController' });
  $locationProvider.html5Mode({enabled:true, requireBase: false});
});

_.mixin(s.exports());
