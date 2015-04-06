angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, $modal, RotiSale, Roti, Lokasi, Sale) ->
  $scope.init = ->
    $scope.newRotiSale = []
    $scope.getRotiSales()
    @saleService = new Sale(serverErrorHandler)
    @lokasiService = new Lokasi(serverErrorHandler)
    @saleService.all().$promise.then (sales) ->
      $scope.sales = sales
    @lokasiService.all().$promise.then (lokasis) ->
      angular.forEach lokasis, (lokasi) ->
        $scope.newRotiSale.push { lokasi: lokasi, rotis: [] }

      rotiService = new Roti(serverErrorHandler)
      rotiService.all().$promise.then (rotis) ->
        angular.forEach rotis, (roti) ->
          $scope.newRotiSale.map (lokasi) ->
            lokasi.rotis.push({ id: roti.id, nama: roti.nama, jumlah: 0, harga: roti.harga})

  $scope.status = false

  $scope.open = ->
    modalInstance = $modal.open({
      templateUrl: 'templates/add_rotisale_modal.html',
      controller: 'AddRotiSaleModalController',
      resolve: {
        newRotiSale: ->
          $scope.newRotiSale
      }
    })

    modalInstance.result.then $scope.getRotiSales

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

  $scope.getRotiSales = ->
    rotiSaleService = new RotiSale(serverErrorHandler)
    rotiSaleService.all().$promise.then (rotisales) ->
      $scope.rotisales = rotisales[0]
