describe(
    "CustomerSearchController", function() {
	describe("Initialisation", function() {
	    var scope = null,
		controller = null;

	    beforeEach(module("customers"));

	    beforeEach(inject(function($controller, $rootScope) {
		scope = $rootScope.$new();
		controller = $controller("CustomerSearchController", {
		    $scope: scope
		});
	    }));

	    it("defaults to an empty customer list", function() {
		expect(scope.customers).toEqualData([]);
	    });
	});
    });
