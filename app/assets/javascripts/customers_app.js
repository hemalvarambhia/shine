app = angular.module("customers", [ "ngRoute", "ngResource", "templates" ]);

app.config([
    "$routeProvider",
    function($routeProvider) {
	$routeProvider.when(
	    "/", {
		controller: "CustomerSearchController",
		templateUrl: "customer_search.html"		
	    }).
	    when(
		"/:id", {
		    controller: "CustomerDetailController",
		    templateUrl: "customer_detail.html"
		}
	    );
    }
]);

var CustomerSearchController = function($scope, $http, $location) {
    var page = 0;
    $scope.customers = [];
    $scope.search = function(searchTerm) {
	if (searchTerm.length < 3) {
	    return;
	}
	$http.get("/customers.json",
		  { "params": {"keywords": searchTerm, "page": page } }
		 ).then(function(response) {
		     $scope.customers = response.data;
		 }, function(response) {
		     alert("There was a problem: " + response.status);
		 }
		       );
    }
    
    $scope.previousPage = function() {
	if(page > 0) {
	    page = page - 1;
	    $scope.search($scope.keywords);
	}
    }

    $scope.nextPage = function() {
	page = page + 1;
	$scope.search($scope.keywords);
    };

    $scope.viewDetails = function(customer) {
	$location.path("/" + customer.id);
    };
};

app.controller(
    "CustomerSearchController",
    [ "$scope", "$http", "$location", CustomerSearchController ]
);


var CustomerDetailController = function($scope, $routeParams, $resource) {
    $scope.customerId = $routeParams.id;
    var Customer = $resource('/customers/:customerId.json')
    $scope.customer = Customer.get({ "customerId": $scope.customerId});
};

app.controller(
    "CustomerDetailController",
    [ "$scope", "$routeParams", "$resource", CustomerDetailController ]
);

var CustomerCreditCardController = function($scope, $resource) {
    var CreditCard = $resource('/fake_billing.json')
    $scope.setCardholderId = function(cardholderId) {
	$scope.creditCard = CreditCard.get({ "cardholder_id": cardholderId })
    }
};

app.controller(
    "CustomerCreditCardController",
    [ "$scope", "$resource", CustomerCreditCardController ]
)
