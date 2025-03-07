(function(){
    'use strict';
    
    angular
      .module('commentsApp', [])
      .controller('CommentsController', CommentsController);
    
    // Inject $scope dependency.
    CommentsController.$inject = ['$scope'];
    
    // Declare CommentsController.
    function CommentsController($scope) {
      var vm = this;
      
      // Current comment.
      vm.comment = {};
  
      // Array where comments will be.
      vm.comments = [];
  
      // Fires when form is submited.
      vm.addComment = function() {
        // Fixed img.
        vm.comment.avatarSrc = 'http://lorempixel.com/200/200/people/';
  
        // Add current date to the comment.
        vm.comment.date = Date.now();
  
        vm.comments.push( vm.comment );
        vm.comment = {};
  
        // Reset clases of the form after submit.
        $scope.form.$setPristine();
      }
    }
  
  })();