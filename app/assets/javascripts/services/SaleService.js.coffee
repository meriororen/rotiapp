angular.module('rotiApp').factory 'Sale', ($resource, $http) ->
  class Sale
    constructor: (errorHandler) ->
      @saleServ = $resource('/api/sales/:id', { id: '@id' }, { update: { method: 'PATCH' }})

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    all: ->
      @saleServ.query (-> null), @errorHandler
