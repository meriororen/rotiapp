angular.module('rotiApp').controller "AddRotiSaleModalController", ($scope, $modalInstance, newRotiSale, RotiSale) ->

  $scope.init = ->
    $scope.newSale = { sales: newRotiSale, total: 0, kelebihan: 0, kekurangan: 0 }
    $scope.recalculate()
    $scope.getTodayDate()

  $scope.selectedTab = 0
  $scope.select = (index) ->
    $scope.selectedTab = index
  $scope.isSelected = (index) ->
    $scope.selectedTab == index

  $scope.getTodayDate = ->
    today = new Date()
    today_date = ("0" + today.getDate()).slice(-2)
    today_month = ("0" + (today.getMonth() + 1)).slice(-2)
    today_year = today.getFullYear()
    $scope.newSale.tanggal = today_date + "." + today_month + "." + today_year

  $scope.submit = (newSale)->
    service = new RotiSale(serverError)
    service.create(newSale, ( (ns) -> null ))
    $modalInstance.close(newSale)

  $scope.change = (roti, type) ->
    switch type
      when 0 then roti.jumlah++
      when 1 then roti.jumlah-- if roti.jumlah > 0
      when 2 then roti.jumlah = 0
    $scope.recalculate()

  $scope.recalculate = ->
    $scope.calculated_total = 0
    $scope.newSale.sales.forEach (lokasi) ->
      lokasi.rotis.forEach (roti) ->
        $scope.calculated_total += roti.jumlah * roti.harga

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


  serverError = ->
    alert("Servernya lagi error. Coba lagi!")

  cleanse = (newSale) ->
    newSale.lokasis.forEach (lokasi, li) ->
      lokasi.rotis.forEach (roti, ri) ->
        newSale.lokasis[li].rotis.splice(ri, 1) if roti.jumlah == 0
      newSale.lokasis.unshift(li, 1) if lokasi.rotis.length == 0
    newSale
