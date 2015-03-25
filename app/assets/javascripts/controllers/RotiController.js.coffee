angular.module('rotiApp').controller "RotiController", ($scope, $route, $routeParams) ->
  $scope.name = "RotiController"
  $scope.params = $routeParams
