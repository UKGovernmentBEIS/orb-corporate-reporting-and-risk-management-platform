'use strict';

const build = require('@microsoft/sp-build-web');

// disable tslint
build.tslintCmd.enabled = false;

// add eslint
const eslint = require('gulp-eslint');
const eslintSubTask = build.subTask('eslint-subTask', function (gulp, buildOptions, done) {
  return gulp.src(['src/**/*.{ts,tsx}'])
    .pipe(eslint('./config/eslint.json'))
    .pipe(eslint.format())
    .pipe(eslint.failAfterError());
});
build.rig.addPreBuildTask(build.task('eslint', eslintSubTask));

const gulp = require('gulp');

build.addSuppression(`Warning - [sass] The local CSS class 'ms-Grid' is not camelCase and will not be type-safe.`);

var getTasks = build.rig.getTasks;
build.rig.getTasks = function () {
  var result = getTasks.call(build.rig);

  result.set('serve', result.get('serve-deprecated'));

  return result;
};

build.initialize(gulp);

// Custom Gulp task to configure the Web Api Permission Request for the package
// Uses modifyFile plugin from https://www.npmjs.com/package/gulp-modify-file
gulp.task('set-web-api-permission-request', () => {
    const modifyFile = require('gulp-modify-file');
 
    function getArgument(key) {
        var index = process.argv.indexOf(key);
  
        if (index > -1 && process.argv.length > index) { 
            return process.argv[index + 1];
        }

        throw "Argument '" + key + "' not supplied.";
    }

    var resource = getArgument('--resource');
    var scope = getArgument('--scope');

    return gulp
    .src('config/package-solution.json')
    .pipe(modifyFile((content, path, file) => {
        var obj = JSON.parse(content); 
        obj.solution.webApiPermissionRequests = [{ "resource" : resource, "scope" : scope }]; 
        return JSON.stringify(obj); 
    }))
    .pipe(gulp.dest('config'));
}); 