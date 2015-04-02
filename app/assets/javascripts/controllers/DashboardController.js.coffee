angular.module('rotiApp').controller "DashboardController", ($scope, $routeParams, $modal, RotiSale, Roti, Lokasi, Sale) ->
  $scope.init = ->
    @rotiSaleService = new RotiSale(serverErrorHandler)
    @saleService = new Sale(serverErrorHandler)
    @lokasiService = new Lokasi(serverErrorHandler)
    @rotiService = new Roti(serverErrorHandler)
    @rotiSaleService.all(assignRotiSales)
    @saleService.all(assignSales)
    @lokasiService.all(assignLokasis)
    @rotiService.all(assignRotis)
    $scope.newRotiSale = {}
    $scope.rotis = []

  $scope.status = false
  
  $scope.open = ->
    modalInstance = $modal.open({
      templateUrl: 'AddRotiSaleTemplate.html',
      controller: 'AddRotiSaleModalInstanceCtrl',
      resolve: {
        newRotiSale: ->
          $scope.newRotiSale
        lokasis: ->
          $scope.lokasis
        rotis: ->
          $scope.rotis
      }
    })

    modalInstance.result.then saveNewRotiSale, (-> null)

  saveNewRotiSale = (newRotiSale) ->
    $scope.newRotiSale = newRotiSale

  assignRotiSales = (rotisales) ->
    $scope.rotisales = rotisales[0]

  assignSales = (sales) ->
    $scope.sales = sales
  
  assignLokasis = (lokasis) ->
    $scope.lokasis = lokasis

  assignRotis = (rotis) ->
    console.log(rotis)
    $scope.rotis = rotis

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

# controller for modal in this page
#
angular.module('rotiApp').controller 'AddRotiSaleModalInstanceCtrl', ($scope, $modalInstance, lokasis, rotis) ->
  $scope.newRotiSale = {}
  $scope.newRoti = {}
  $scope.curLokasi = {}
  $scope.lokasis = lokasis
  $scope.rotis = rotis
  $scope.newRotiSale.lokasi = $scope.lokasis[0]
  $scope.newRoti.nama = $scope.rotis[0]
  $scope.newRotiSale.rotis = []

  getTodayDate = ->
    today = new Date()
    today_date = ("0" + today.getDate()).slice(-2)
    today_month = ("0" + (today.getMonth() + 1)).slice(-2)
    today_year = today.getFullYear()
    $scope.newRotiSale.tanggal = today_date + "." + today_month + "." + today_year

  getTodayDate()

  $scope.submit = (newRotiSale)->
    $scope.newRotiSale.rotis.push($scope.newRoti)
    $modalInstance.close(newRotiSale)

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


