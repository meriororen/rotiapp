angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, RotiSale, Roti, Lokasi, Sale) ->
  $scope.init = ->
    @rotiSaleService = new RotiSale(serverErrorHandler)
    @saleService = new Sale(serverErrorHandler)
    @lokasiService = new Lokasi(serverErrorHandler)
    @rotiSaleService.all(assignRotiSales)
    @saleService.all(assignSales)
    @lokasiService.all(assignLokasis)
    $scope.newSale = {} 

  $scope.status = false
  
  $scope.addRotiSale = (newSale) ->
    console.log(newSale)

  assignRotiSales = (rotisales) ->
    $scope.rotisales = rotisales[0]

  assignSales = (sales) ->
    $scope.sales = sales
  
  assignLokasis = (lokasis) ->
    $scope.lokasis = lokasis
    $scope.newSale.lokasi = $scope.lokasis[0]

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

