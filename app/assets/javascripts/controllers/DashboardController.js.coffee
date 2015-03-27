angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, Sale, Roti) ->
  $scope.init = ->
    @saleService = new Sale(serverErrorHandler)
    $scope.sales = @saleService.all()

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")
