angular.module('rotiApp').factory 'Roti', ($resource, $http) ->
  class Roti
    constructor: (errorHandler) ->
      @rotisServ = $resource('/api/rotis')
      @rotiServ = $resource('/api/rotis/:id', { id: '@id' }, { update: { method: 'PATCH' }})
      @errorHandler = errorHandler

      # Fix needed for PATCH
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @rotisServ(attrs).$save ((roti) ->
        successHandler(roti)
      ), @errorHandler

    delete: (roti) ->
      new @rotiServ().$delete {id: roti.id},(-> null), @errorHandler

    all: ->
      @rotisServ.query (-> null), @errorHandler
