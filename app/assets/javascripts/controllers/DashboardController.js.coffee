angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, Sale) ->
  $scope.init = ->
    @saleService = new Sale(serverErrorHandler)
    $scope.sales = @saleService.all()
  
  serverErrorHandler = ->
    alert("Servernya error, coba lagi")
