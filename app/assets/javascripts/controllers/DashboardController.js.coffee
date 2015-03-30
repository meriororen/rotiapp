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
  $scope.lokasis = lokasis
  $scope.rotis = rotis
  $scope.newRotiSale.lokasi = $scope.lokasis[0]
  $scope.newRotiSale.rotis = $scope.rotis[0]

  getTodayDate = ->
    today = new Date()
    $scope.newRotiSale.tanggal = today.toDateString()

  getTodayDate()

  $scope.submit = (newRotiSale)->
    console.log(newRotiSale)
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


