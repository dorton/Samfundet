angular.module('reservation.services', ['rails'])
.factory('Reservation', ['railsResourceFactory', '$http', '$filter', function (railsResourceFactory, $http, $filter) {
    var resource = railsResourceFactory({url: '/lyche/reservations', name: 'sulten_reservation'});

    resource.prototype.findAvailablePeriods = function(from, duration, people, reservation_type_id){
      var request = {
        method: 'GET',
        url: resource.resourceUrl(this.id) + '/available_periods',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        params: {
          from: from,
          duration: duration,
          people: people,
          reservation_type_id: reservation_type_id
        }
      }
      var get = $http(request).then(function(available_periods){
        return available_periods;
      });
      return get;
    };
    return resource;
}]);

angular.module('reservation.controllers', ["ui.router"])
.config(function($stateProvider) {
  $stateProvider.state("Default", {});

  $stateProvider.state("Modal", {
    views:{
      "modal": {
        templateUrl: "/lyche/reservations/modal.html"
      }
    },
    onEnter: ["$state", function($state) {
      $(document).on("keyup", function(e) {
        if(e.keyCode == 27) { // ESC
          $(document).off("keyup");
          $state.go("Default");
        }
      });

      $(document).on("click", ".Modal-backdrop, .Modal-holder", function() {
        $state.go("Default");
      });

      $(document).on("click", ".Modal-box, .Modal-box *", function(e) {
        e.stopPropagation();
      });
    }],
    abstract: false
  });
})

.controller('ReservationCtrl', ['$scope', '$q', '$state', '$window', '$filter', 'Reservation', function ($scope, $q, $state, $window, $filter, Reservation) {

  $scope.reservation = new Reservation({
    "people": 1,
    "reservationFrom": $filter('date')(new Date(), "dd.MM.yyyy"),
    "reservationDuration": document.getElementById("sulten_reservation_reservation_duration").options[0].value,
    "name": "",
    "reservationTypeId": document.getElementById("sulten_reservation_reservation_type_id").options[0].value,
    "telephone": "",
    "email": "",
    "allergies": ""
  });

  $scope.tempReservationFrom = null;

  $scope.updateAvailablePeriods = function() {
    var q = $q.defer();
    if ($scope.reservation["reservationFrom"] && $scope.reservation["reservationDuration"] && $scope.reservation["people"] && $scope.reservation["reservationTypeId"])
      $scope.reservation.findAvailablePeriods($scope.reservation["reservationFrom"], $scope.reservation["reservationDuration"], $scope.reservation["people"], $scope.reservation["reservationTypeId"])
      .then(function(response){
        $scope.availablePeriods = response.data;
        $scope.tempReservationFrom = $scope.reservation["reservationFrom"];
        q.resolve(response);
      });
    else
      q.reject();
    return q.promise;
  };

  $scope.setPeriod = function(period){
    $scope.tempReservationFrom = period;
  };

  $scope.errorIds = [];

  $scope.onSubmit = function(evt){
    evt.preventDefault();
    if ($state.current.name == "Modal") {
      var tmp = $scope.tempReservationFrom;
      $scope.tempReservationFrom = $scope.reservation["reservationFrom"];
      $scope.reservation["reservationFrom"] = tmp;
      $scope.reservation.create().then(function(response){
        if (response.status === 200){
          $window.location.href = response.redirect;
        } else{
          $scope.reservation["reservationFrom"] = $scope.tempReservationFrom;
          $scope.$emit('event:form-FormErrors', 'sulten_reservation', response.errors);
          $state.go("Default");
          delete $scope.reservation.status;
          delete $scope.reservation.errors;
        }
      });
    } else {
      $scope.updateAvailablePeriods().then(function(response){
        $state.go('Modal')
      })
    }
  };
}]);

angular.module('reservation.directives', [])
.directive ('formtasticInlineErrors', function($compile) {
  return {
    restrict: 'A',
    link: function (scope, element, attrs) {
      scope.$on ('event:form-FormErrors', function(evt, model_name, errors) {
        element.find('.input .inline-errors').remove();
        for (var key in errors) {
          if (errors.hasOwnProperty(key)) {
            error_html = '<p class="inline-errors">'+errors[key].join(", ")+"</p>"
            element.find('#'+model_name+'_'+key+'_input').append(error_html);
          }
        }
      })
    }
  };
});


angular.module('reservation', ['reservation.services', 'reservation.directives', 'reservation.controllers']);
