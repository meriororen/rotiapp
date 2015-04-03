angular.module('rotiApp').factory 'RotiSale', ($resource, $http) ->
  class RotiSale
    constructor: (errorHandler) ->
      @rotiSaleServ = $resource('/api/roti_sales/:id', { id: '@id' }, { update: { method: 'PATCH' }})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs, successHandler) ->
      new @rotiSaleServ(attrs).$save ((rs) ->
        successHandler(rs)
      ), @errorHandler

    all: ->
      @rotiSaleServ.query((-> null), @errorHandler)
