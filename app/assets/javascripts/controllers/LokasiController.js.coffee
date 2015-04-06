angular.module('rotiApp').controller "LokasiController", ($scope, $route, $routeParams, Lokasi) ->

  $scope.init = ->
    @lokasiService = new Lokasi(serverErrorHandler)
    $scope.lokasis = @lokasiService.all()

  $scope.addLokasi = (newLokasi) ->
    @lokasiService.create(newLokasi, successHandler)
    $scope.newLokasi.nama = ""
    $scope.newLokasi.penanggung_jawab = ""

  $scope.deleteLokasi = (lokasi) ->
    if confirm("Hapus Lokasi '" + lokasi.nama + "'?")
      @lokasiService.delete(lokasi)
      $scope.lokasis.splice($scope.lokasis.indexOf(lokasi), 1)

  successHandler = (lokasi) ->
    $scope.lokasis.push(lokasi)

  serverErrorHandler = ->
    alert("Servernya Error, Coba Lagi!")
