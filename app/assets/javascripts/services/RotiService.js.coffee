angular.module('rotiApp').factory 'Roti', ($resource, $http) ->
  class Roti
    constructor: (errorHandler) ->
      @service = $resource('/api/rotis/:id', {id: '@id'}, {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      # Fix needed for PATCH
      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs) ->
      new @service(roti: attrs).$save ((roti) -> attrs.id = roti.id), @errorHandler
      attrs

    delete: (roti) ->
      new @service().$delete {id: roti.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)
