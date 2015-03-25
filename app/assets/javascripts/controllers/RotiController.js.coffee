angular.module('rotiApp').controller "RotiController", ($scope, $route, $routeParams, Roti) ->
  
  $scope.init = ->
    @rotiService = new Roti($routeParams.id, serverErrorHandler)
    $scope.rotis = @rotiService.all()

  serverErrorHandler = ->
    alert("There was a server error, please reload the page and try again.")
