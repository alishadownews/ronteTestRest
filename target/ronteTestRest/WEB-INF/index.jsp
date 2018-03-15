<!doctype html>
<html ng-app="accountApp">
<head>
<meta charset="utf-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!--	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.3/angular.min.js"></script>
-->	
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
	</script><script type="text/javascript">

	
	


/*
var model = {
    items: [
        { id: 10, accountDetails: "zsdfsdfasdfasdfasdfasdfsadfe" },
        { id: 20, accountDetails: "bnjfdgsadfaefsdgsdrqwrsdfsdf" },
        { id: 30, accountDetails: "sdrqwedsdfsdgdgfhbnmswdrsdfg"},
        { id: 40, accountDetails: "uioifghdfgsdfsfgsdfsdfserfsd" }
    ]
};
*/

var port = '8081';

var accountApp = angular.module("accountApp", []);
accountApp.controller("accountController", function ($scope, $http) {
    //$scope.list = model;

        $scope.emptyAccount = {id: "", accountDetails: ""};
        $scope.editAccount = angular.copy($scope.emptyAccount);

        $scope.editMode = false;

        // обновить список
        $http.get('http://localhost:'+ port + '/ronteTestRest/accounts').
            then(function(response) {
                $scope.list = { "items" : response.data};
             }, function error(response){
                console.log('error');
                alert("Не получилось обновить список, проверьте правильность работы сервера");
             }
        );




        // добавление
        $scope.addItem = function () {

            if( ($scope.editAccount.accountDetails != "" && $scope.editAccount.accountDetails != undefined) )
            {
                var parameter = JSON.stringify({id: $scope.editAccount.id, accountDetails: $scope.editAccount.accountDetails});
                $http.post('http://localhost:'+ port + '/ronteTestRest/account', parameter).
                    then(function(response){
                        $scope.editAccount = angular.copy($scope.emptyAccount);

                        $http.get('http://localhost:'+ port + '/ronteTestRest/accounts').
                        then(function(response) {
                            $scope.list = { "items" : response.data};
                        });

                    }, function error(response) {

                        console.log(response.data);
                    }
                );

            }

        }

        // режим редактирования включить
        $scope.updateModeOn = function (inIdStr) {
            inId = parseFloat(inIdStr); // преобразуем введенное значение к числу
            if( !isNaN(inId))
            {

                // обновить список
                $http.get('http://localhost:'+ port + '/ronteTestRest/account/'+inIdStr).
                then(function(response) {
                        $scope.editAccount = response.data;
                        $scope.editMode = true;
                    }, function error(response){
                        console.log('error');
                        alert("Не получилось получить данные, проверьте правильность работы сервера");
                    }
                );
            }
        }


        // режима редактирования включить
        $scope.updateModeOff = function () {
            $scope.editMode = false
            $scope.editAccount = angular.copy($scope.emptyAccount);
        }

        // редактировать- обновить
        $scope.updateItem = function () {
            var parameter = JSON.stringify({id: $scope.editAccount.id, accountDetails: $scope.editAccount.accountDetails});
            $http.put('http://localhost:'+ port + '/ronteTestRest/accounts', parameter).
            then(function(response){
                $scope.editMode = false
                $scope.editAccount = angular.copy($scope.emptyAccount);


                $http.get('http://localhost:'+ port + '/ronteTestRest/accounts').
                then(function(response) {
                    $scope.list = { "items" : response.data};
                });

            }, function error(response) {

                console.log(response.data);
            }
            );

        }


        // удаление
        $scope.deleteItem = function (inIdStr) {
            inId = parseFloat(inIdStr); // преобразуем введенное значение к числу
            if( !isNaN(inId))
            {
                var parameter = "";
                $http.delete('http://localhost:'+ port + '/ronteTestRest/accounts/'+inIdStr, parameter).
                then (function(response){
                    $http.get('http://localhost:'+ port + '/ronteTestRest/accounts/').
                    then(function(response) {
                        $scope.list = { "items" : response.data};
                    });

                }, function error(response){
                    console.log(response.data);
                });
            }
        }

});
	
	
	
	
	
	</script>

</head>
<body ng-controller="accountController">



    <div class="page-header">
        <h1> List accounts </h1>
    </div>
    <div class="panel">
       	<div class="form-inline" >
			<div class="form-group-hiden" hidden="true" >
				<div class="col-md-id">
					<input class="form-control" ng-model="editAccount.id" 	placeholder = "id" />
			   	</div>
		   	</div>
		   	<div class="form-group">
			   	<div class="col-md-firstName">
				   	<input class="form-control" ng-model="editAccount.accountDetails" 	placeholder = "accountDetails"  />
			   	</div>
		   	</div>
			<div class="form-group" ng-show="!editMode">
				<div class="col-md-btnAdd">
					<button class="btn btn-default" ng-click="addItem()">Add</button>
				</div>
			</div>
			<div class="form-group" ng-show="editMode" >
				<div class="col-md-btnUpdateEdit">
					<button class="btn btn-default"  ng-click="updateItem()">Edit</button>
				</div>
			</div>
			<div class="form-group" ng-show="editMode" >
				<div class="col-md-btnUpdateEdit">
					<button class="btn btn-default"  ng-click="updateModeOff()">Cancel edit</button>
				</div>
			</div>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
					<th>id</th>
					<th>accountDetails</th>
					<th>Edit</th>
					<th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <tr ng-repeat="item in list.items">
					<td>{{item.id}}</td>
					<td>{{item.accountDetails}}</td>
					<td><button class="btn btn-default" ng-click="updateModeOn(item.id)">Edit</button></td>
					<td><button class="btn btn-default" ng-click="deleteItem(item.id)">Delete</button></td>
                </tr>
            </tbody>
        </table>
    </div>


	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>


</body>
</html>
</html>