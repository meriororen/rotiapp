angular.module('rotiApp').controller "AddRotiSaleModalController", ($scope, $modalInstance, lokasis, RotiSale) ->
  $scope.newSale = { tanggal: null, sales: lokasis }

  getTodayDate()

  $scope.selectedTab = 0
  $scope.select = (index) ->
    $scope.selectedTab = index
  $scope.isSelected = (index) ->
    $scope.selectedTab == index

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

  $scope.openDatePicker = ($event) ->
    $event.preventDefault()
    $event.stopPropagation()

    $scope.opened = true

  $scope.dateOptions = {
    formatYear: 'yy',
    startingDay: 1
  }

  getTodayDate = ->
    today = new Date()
    today_date = ("0" + today.getDate()).slice(-2)
    today_month = ("0" + (today.getMonth() + 1)).slice(-2)
    today_year = today.getFullYear()
    $scope.newSale.tanggal = today_date + "." + today_month + "." + today_year

  serverError = ->
    alert("Servernya lagi error. Coba lagi!")

  cleanse = (newSale) ->
    newSale.lokasis.forEach (lokasi, li) ->
      lokasi.rotis.forEach (roti, ri) ->
        newSale.lokasis[li].rotis.splice(ri, 1) if roti.jumlah == 0
      newSale.lokasis.unshift(li, 1) if lokasi.rotis.length == 0
    newSale
