angular.module('rotiApp').controller "AddRotiSaleModalController", ($scope, $modalInstance, newRotiSale, sales, $filter, RotiSale) ->
  $scope.init = ->
    $scope.newSale = { rotisales: newRotiSale, sale: { total: 0, kelebihan: 0, kekurangan: 0 }}
    $scope.recalculate()
    $scope.getTodayDate()
    $scope.sales = sales
    $scope.exists()

  $scope.selectedTab = 0
  $scope.select = (index) ->
    $scope.selectedTab = index
  $scope.isSelected = (index) ->
    $scope.selectedTab == index

  to_proper_date = (date) ->
    $filter('date') date, 'MMM dd, yyyy'

  $scope.exists = ->
    $scope.existed = false
    $scope.sales.forEach (sale) ->
      if (to_proper_date(sale.tanggal) == to_proper_date($scope.newSale.sale.tanggal))
        $scope.existed = true

  $scope.$watch 'newSale.sale.tanggal', ((newVal, oldVal) ->
    $scope.exists() if (newVal != oldVal)
  )

  $scope.$watch 'newSale.sale.total', ((total) ->
    $scope.recalculate_margin()
  )

  $scope.recalculate_margin = ->
    margin = $scope.newSale.sale.total - $scope.calculated_total
    $scope.newSale.kelebihan = if (margin <= 0) then 0 else margin
    $scope.newSale.kekurangan = if (margin >= 0) then 0 else margin

  $scope.getTodayDate = ->
    month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    today = new Date()
    today_date = ("0" + today.getDate()).slice(-2)
    today_month = month[today.getMonth()]
    today_year = today.getFullYear()
    $scope.newSale.sale.tanggal = today_month + " " + today_date + ", " + today_year

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
    $scope.newSale.rotisales.forEach (lokasi) ->
      lokasi.rotis.forEach (roti) ->
        $scope.calculated_total += roti.jumlah * roti.harga
    $scope.recalculate_margin()

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
