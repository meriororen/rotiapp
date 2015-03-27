angular.module('rotiApp').factory 'Sale', ($resource, $http) ->
  class Sale
    constructor: (errorHandler) ->
      @saleServ = $resource('/api/sales/:id', { id: '@id' }, { update: { method: 'PATCH' }})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @saleServ(attrs).$save ((rs) ->
        successHandler(rs)
      ), @errorHandler

    all: ->
      @saleServ.query (-> null), @errorHandler
