angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, $modal, RotiSale, Roti, Lokasi, Sale) ->
  $scope.init = ->
    $scope.newRotiSale = {}
    $scope.lokasis = []
    @rotiSaleService = new RotiSale(serverErrorHandler)
    @saleService = new Sale(serverErrorHandler)
    @lokasiService = new Lokasi(serverErrorHandler)

    @rotiSaleService.all().$promise.then (rotisales) ->
      $scope.rotisales = rotisales[0]
    @saleService.all().$promise.then (sales) ->
      $scope.sales = sales
    @lokasiService.all().$promise.then (lokasis) ->
      angular.forEach lokasis, (lokasi) ->
        $scope.lokasis.push { lokasi: lokasi, rotis: [] }
      rotiService = new Roti(serverErrorHandler)
      rotiService.all().$promise.then (rotis) ->
        angular.forEach rotis, (roti) ->
          $scope.lokasis.map (lokasi) ->
            lokasi.rotis.push({ nama: roti.nama, jumlah: 0 })

  $scope.status = false

  $scope.open = ->
    modalInstance = $modal.open({
      templateUrl: 'AddRotiSaleTemplate.html',
      controller: 'AddRotiSaleModalInstanceCtrl',
      resolve: {
        lokasis: ->
          $scope.lokasis
      }
    })

    modalInstance.result.then saveNewRotiSale, (-> null)

  saveNewRotiSale = (newRotiSale) ->
    $scope.newRotiSale = newRotiSale

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

# controller for modal in this page
#
angular.module('rotiApp').controller 'AddRotiSaleModalInstanceCtrl', ($scope, $modalInstance, lokasis) ->
  $scope.newSale = { lokasis: lokasis }

  getTodayDate = ->
    today = new Date()
    today_date = ("0" + today.getDate()).slice(-2)
    today_month = ("0" + (today.getMonth() + 1)).slice(-2)
    today_year = today.getFullYear()
    $scope.newSale.tanggal = today_date + "." + today_month + "." + today_year

  getTodayDate()

  $scope.submit = (newRotiSale)->
    $modalInstance.close(newRotiSale)

  $scope.increment = (roti) ->
    roti.jumlah++

  $scope.decrement = (roti) ->
    if (roti.jumlah > 0)
      roti.jumlah--
 
  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  # for datepicker
  #
  $scope.openDatePicker = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()

    $scope.opened = true

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1
  }


