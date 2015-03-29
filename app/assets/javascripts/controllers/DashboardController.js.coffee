angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, Sale, Roti) ->
  $scope.init = ->
    @saleService = new Sale(serverErrorHandler)
    @saleService.all(successHandler)

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

  successHandler = (sales) ->
    $scope.sales = sales[0]
