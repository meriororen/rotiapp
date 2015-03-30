angular.module('rotiApp').factory 'Lokasi', ($resource, $http) ->
  class Lokasi
    constructor: (errorHandler) ->
      @lokasiServ = $resource('/api/lokasis/:id', { id: '@id' }, { update: { method: 'PATCH' }})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: (successHandler) ->
      @lokasiServ.query ((lokasi)-> successHandler(lokasi)), @errorHandler
