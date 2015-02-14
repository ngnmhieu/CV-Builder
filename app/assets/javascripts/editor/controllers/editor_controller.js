var app = angular.module('ResumeApp');


app.controller('EditorController', ['$scope','$resource', function($scope,$resource) {

  Resume = $resource(
    '/resumes/:resume_id', 
    {resume_id: 15},
    {
      query: {method: 'GET', url: '/resumes/:resume_id/edit.json'}
    }
  );

  this.init = function() {
    var resume = Resume.query();
    console.log(resume);
  };

  this.init();

}]);
