angular.module('rotiApp').controller "RotiController", ($scope, $route, $routeParams, Roti) ->
  
  $scope.init = ->
    @rotiService = new Roti(serverErrorHandler)
    $scope.rotis = @rotiService.all()

  $scope.addRoti = (newEntry) ->
    @rotiService.create(newEntry, successHandler)
    $scope.newEntry.nama = ""
    $scope.newEntry.harga = ""

  $scope.deleteRoti = (roti) ->
    if confirm("Beneran mau hapus " + roti.nama + "id(" + roti.id + ")?")
      @rotiService.delete(roti) 
      $scope.rotis.splice($scope.rotis.indexOf(roti), 1)

  $scope.isEmpty = (str) ->
    _.isBlank(str)

  serverErrorHandler = ->
    alert("Servernya error, coba lagi")

  successHandler = (roti) ->
    $scope.rotis.push(roti)


