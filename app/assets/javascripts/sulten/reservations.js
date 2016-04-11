angular.module('reservation.services', ['rails'])
angular.module('reservation.services')
.factory('Reservation', ['railsResourceFactory', '$http', '$filter', function (railsResourceFactory, $http, $filter) {
    var resource = railsResourceFactory({url: '/lyche/reservations', name: 'sulten_reservation'});

    resource.prototype.find_available_periods = function(from, duration, people, reservation_type_id){
      var request = {
        method: 'GET',
        url: resource.resourceUrl(this.id) + '/available_periods' + '?'
          + 'from=' + from + '&'
          + 'duration=' + duration + '&'
          + 'people=' + people + '&'
          + 'reservation_type_id=' + reservation_type_id,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        parameters: {'available_periods': {
          from: from
        }}
      }
      var get = $http(request).then(function(available_periods){
        return available_periods;
      });
      return get;
    };
    return resource;
}]);

angular.module('reservation.controllers', [])
.controller('ReservationCtrl', ['$scope', '$window', '$filter', 'Reservation', function ($scope, $window, $filter, Reservation) {

  $scope.reservation = new Reservation({
    people: 1,
    reservationFrom: $filter('date')(new Date(), "dd.MM.yyyy"),
    reservationDuration: null,
    name:"",
    reservationTypeId: null,
    telephone: "",
    email:"",
    allergies: ""
  });

  $scope.$watchGroup(['reservation.reservationFrom', 'reservation.reservationDuration', 'reservation.people', 'reservation.reservationTypeId'], function() {
    $scope.reservation.find_available_periods($scope.reservation.reservationFrom, $scope.reservation.reservationDuration, $scope.reservation.people, $scope.reservation.reservationTypeId)
    .then(function(response){
      $scope.available_periods = response.data;
    });
  }, true);

  $scope.save = function(period){
    $scope.reservation.reservationFrom = period;
    $scope.reservation.create().then(function(response){
      if (response.redirect){
        $window.location.href = response.redirect;
      } else{
        $scope.reservation.reservationFrom = $filter('date')(new Date(), "dd.MM.yyyy")
        alert("Could not create reservation");
      }
    });
  };

}]);

angular.module('reservation', ['reservation.services', 'reservation.controllers']);
