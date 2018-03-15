<!doctype html>
<html ng-app="employeeApp">
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
        { id: 10, firstName: "Perviy", lastName: "Pasdf", patronymic: "Psdfsd", departament: "Psdfs" },
        { id: 20, firstName: "Vtoroy", lastName: "Vsdfgas", patronymic: "Vsdf", departament: "Vdfgs" },
        { id: 30, firstName: "Tretiy", lastName: "Tdsfgs", patronymic: "Tdsfgsd", departament: "Tzsdgs"},
        { id: 40, firstName: "Chetvertiy", lastName: "Cdsfg", patronymic: "Csdf", departament: "Cdfg" }
    ]
};
*/

var employeeApp = angular.module("employeeApp", []);
employeeApp.controller("employeeController", function ($scope, $http) {
    //$scope.list = model;

        $scope.emptyEmployee = {id: "", firstName: "", lastName: "", patronymic: "", departament: ""};
        $scope.editEmployee = angular.copy($scope.emptyEmployee);

        $scope.editMode = false;

        // обновить список
        $http.get('http://localhost:8080/mdhTestRest/employees').
            then(function(response) {
                $scope.list = { "items" : response.data};
             }, function error(response){
                console.log('error');
                alert("Не получилось обновить список, проверьте правильность работы сервера");
             }
        );




        // добавление
        $scope.addItem = function () {

            if(($scope.editEmployee.firstName != "" && $scope.editEmployee.firstName != undefined)
                && ($scope.editEmployee.lastName != "" && $scope.editEmployee.lastName != undefined)
                && ($scope.editEmployee.patronymic != "" && $scope.editEmployee.patronymic != undefined)
                && ($scope.editEmployee.departament != "" && $scope.editEmployee.departament != undefined) )
            {
                //$scope.list.items.push({ id: inId, firstName: inFirstName, lastName: inLastName, patronymic: inPatronymic, departament:inDepartament });
                var parameter = JSON.stringify({id: $scope.editEmployee.id, firstName: $scope.editEmployee.firstName, lastName: $scope.editEmployee.lastName, patronymic: $scope.editEmployee.patronymic, departament: $scope.editEmployee.departament});
                $http.post('http://localhost:8080/mdhTestRest/employees', parameter).
                    then(function(response){
                        $scope.editEmployee = angular.copy($scope.emptyEmployee);

                        $http.get('http://localhost:8080/mdhTestRest/employees').
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
                $http.get('http://localhost:8080/mdhTestRest/employees/'+inIdStr).
                then(function(response) {
                        $scope.editEmployee = response.data;
                        $scope.editMode = true;
                    }, function error(response){
                        console.log('error');
                        alert("Не получилось получить данные пользователя, проверьте правильность работы сервера");
                    }
                );
            }
        }


        // режима редактирования включить
        $scope.updateModeOff = function () {
            $scope.editMode = false
            $scope.editEmployee = angular.copy($scope.emptyEmployee);
        }

        // редактировать- обновить
        $scope.updateItem = function () {
            var parameter = JSON.stringify({id: $scope.editEmployee.id, firstName: $scope.editEmployee.firstName, lastName: $scope.editEmployee.lastName, patronymic: $scope.editEmployee.patronymic, departament: $scope.editEmployee.departament});
            $http.put('http://localhost:8080/mdhTestRest/employees', parameter).
            then(function(response){
                $scope.editMode = false
                $scope.editEmployee = angular.copy($scope.emptyEmployee);


                $http.get('http://localhost:8080/mdhTestRest/employees').
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
                $http.delete('http://localhost:8080/mdhTestRest/employees/'+inIdStr, parameter).
                then (function(response){
                    $http.get('http://localhost:8080/mdhTestRest/employees/').
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
<body ng-controller="employeeController">



    <div class="page-header">
        <h1> Список сотрудников </h1>
    </div>
    <div class="panel">
       	<div class="form-inline" >
			<div class="form-group-hiden" hidden="true" >
				<div class="col-md-id">
					<input class="form-control" ng-model="editEmployee.id" 	placeholder = "Номер" />
			   	</div>
		   	</div>
		   	<div class="form-group">
			   	<div class="col-md-firstName">
				   	<input class="form-control" ng-model="editEmployee.firstName" 	placeholder = "Фамилия"  />
			   	</div>
		   	</div>
		   	<div class="form-group">
				<div class="col-md-lastName">
					<input class="form-control" ng-model="editEmployee.lastName" 	placeholder = "Имя" />
				</div>
		   	</div>
			<div class="form-group">
				<div class="col-md-patronymic">
					<input class="form-control" ng-model="editEmployee.patronymic" 	placeholder = "Отчество"  />
				</div>
			</div>
            <div class="form-group">
                <div class="col-md-departament">
                    <input class="form-control" ng-model="editEmployee.departament" 	placeholder = "Отдел"  />
                </div>
            </div>
			<div class="form-group" ng-show="!editMode">
				<div class="col-md-btnAdd">
					<button class="btn btn-default" ng-click="addItem()">Добавить</button>
				</div>
			</div>
			<div class="form-group" ng-show="editMode" >
				<div class="col-md-btnUpdateEdit">
					<button class="btn btn-default"  ng-click="updateItem()">Отредактировать</button>
				</div>
			</div>
			<div class="form-group" ng-show="editMode" >
				<div class="col-md-btnUpdateEdit">
					<button class="btn btn-default"  ng-click="updateModeOff()">Отмена редактирования</button>
				</div>
			</div>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
					<th>Номер</th>
					<th>Фамилия</th>
					<th>Имя</th>
                    <th>Отчество</th>
					<th>Отдел</th>
					<th>Изменить</th>
					<th>Удалить</th>
                </tr>
            </thead>
            <tbody>
                <tr ng-repeat="item in list.items">
					<td>{{item.id}}</td>
					<td>{{item.firstName}}</td>
					<td>{{item.lastName}}</td>
					<td>{{item.patronymic}}</td>
					<td>{{item.departament}}</td>
					<td><button class="btn btn-default" ng-click="updateModeOn(item.id)">Изменить</button></td>
					<td><button class="btn btn-default" ng-click="deleteItem(item.id)">Удалить</button></td>
                </tr>
            </tbody>
        </table>
    </div>


	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>


</body>
</html>