angular.module('rotiApp').controller "RotiController", ($scope, $route, $routeParams, Roti) ->
  
  $scope.init = ->
    @rotiService = new Roti(serverErrorHandler)
    $scope.rotis = @rotiService.all()

  $scope.addRoti = (newRoti) ->
    roti = @rotiService.create(newRoti)
    console.log(roti.nama)
    $scope.newRoti.nama = ""
    $scope.newRoti.harga = ""

  $scope.deleteRoti = (roti) ->
    if confirm("Beneran mau hapus " + roti.nama + "?")
      @rotiService.delete(roti) 
      $scope.rotis.splice($scope.rotis.indexOf(roti), 1)

  $scope.isEmpty = (str) ->
    _.isBlank(str)

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")


