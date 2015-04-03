angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, $modal, RotiSale, Roti, Lokasi, Sale) ->
  $scope.init = ->
    $scope.getRotiSales()
    @saleService = new Sale(serverErrorHandler)
    @lokasiService = new Lokasi(serverErrorHandler)
    $scope.lokasis = []
    @saleService.all().$promise.then (sales) ->
      $scope.sales = sales
    @lokasiService.all().$promise.then (lokasis) ->
      angular.forEach lokasis, (lokasi) ->
        $scope.lokasis.push { lokasi: lokasi, rotis: [] }
      rotiService = new Roti(serverErrorHandler)
      rotiService.all().$promise.then (rotis) ->
        angular.forEach rotis, (roti) ->
          $scope.lokasis.map (lokasi) ->
            lokasi.rotis.push({ id: roti.id, nama: roti.nama, jumlah: 0 })

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

    modalInstance.result.then $scope.getRotiSales

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

  $scope.getRotiSales = ->
    rotiSaleService = new RotiSale(serverErrorHandler)
    rotiSaleService.all().$promise.then (rotisales) ->
      $scope.rotisales = rotisales[0]

# controller for modal in this page
#
angular.module('rotiApp').controller "AddRotiSaleModalInstanceCtrl", ($scope, $modalInstance, lokasis, RotiSale) ->
  $scope.newSale = { tanggal: null, sales: lokasis }

  getTodayDate = ->
    today = new Date()
    today_date = ("0" + today.getDate()).slice(-2)
    today_month = ("0" + (today.getMonth() + 1)).slice(-2)
    today_year = today.getFullYear()
    $scope.newSale.tanggal = today_date + "." + today_month + "." + today_year

  $scope.selectedTab = 0
  $scope.select = (index) ->
    $scope.selectedTab = index
  $scope.isSelected = (index) ->
    $scope.selectedTab == index

  getTodayDate()

  $scope.submit = (newSale)->
    service = new RotiSale(serverError)
    service.create(newSale, ( (ns) -> null ))
    $modalInstance.close(newSale)

  $scope.increment = (roti) ->
    roti.jumlah++

  $scope.clear = (roti) ->
    roti.jumlah = 0

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

  serverError = ->
    alert("Servernya lagi error. Coba lagi!")

  cleanse = (newSale) ->
    newSale.lokasis.forEach (lokasi, li) ->
      lokasi.rotis.forEach (roti, ri) ->
        newSale.lokasis[li].rotis.splice(ri, 1) if roti.jumlah == 0
      newSale.lokasis.unshift(li, 1) if lokasi.rotis.length == 0
    newSale
