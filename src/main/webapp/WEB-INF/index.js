
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
	
	
	
	