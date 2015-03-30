angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, RotiSale, Roti, Lokasi, Sale) ->
  $scope.init = ->
    @rotiSaleService = new RotiSale(serverErrorHandler)
    @saleService = new Sale(serverErrorHandler)
    @lokasiService = new Lokasi(serverErrorHandler)
    @rotiSaleService.all(assignRotiSales)
  
  $scope.addRotiSale = (newSale) ->
    newSale

  $scope.requestReqdData = ->
    @saleService.all(assignSales)
    @lokasiService.all(assignLokasis)

  assignRotiSales = (rotisales) ->
    $scope.rotisales = rotisales[0]

  assignSales = (sales) ->
    $scope.sales = sales
  
  assignLokasis = (lokasis) ->
    $scope.lokasis = lokasis
    $scope.newSale.lokasi = lokasis[0]

  serverErrorHandler = ->
      alert("Servernya error, coba lagi")


