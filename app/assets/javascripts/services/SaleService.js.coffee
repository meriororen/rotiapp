angular.module('rotiApp').factory 'RotiSale', ($resource, $http) ->
  class RotiSale
    constructor: (errorHandler) ->
      @salesService = $resource('/api/rotisales/:id', { id: '@id' }
