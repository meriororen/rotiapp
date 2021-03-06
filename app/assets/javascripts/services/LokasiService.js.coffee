angular.module('rotiApp').factory 'Lokasi', ($resource, $http) ->
  class Lokasi
    constructor: (errorHandler) ->
      @lokasiServ = $resource('/api/lokasis/:id', { id: '@id' }, { update: { method: 'PATCH' }})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @lokasiServ(attrs).$save ((lokasi) ->
        successHandler(lokasi)
      ), @errorHandler

    delete: (lokasi) ->
      new @lokasiServ().$delete {id: lokasi.id},(-> null), @errorHandler

    all: ->
      @lokasiServ.query (-> null), @errorHandler
