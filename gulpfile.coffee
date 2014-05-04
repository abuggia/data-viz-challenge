# thank you greypants: https://github.com/greypants/gulp-starter
gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
connect = require('connect')
livereload = require('gulp-livereload')
http = require('http')
path = require('path')

buildDir = "build"
connectPort = "8080"


gulp.task 'serve', ->
  app = connect()
    .use(connect.logger('dev'))
    .use(connect.static(path.resolve("./")))

  http.createServer(app).listen(connectPort)


gulp.task 'coffee', ->
  gulp.src('./src/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest("./#{buildDir}/"))


gulp.task 'watch', ->
  gulp.watch('src/*.coffee', ['coffee'])

  server = livereload()
  gulp.watch("#{buildDir}/**").on	'change', (file) ->
    console.log("saw a change")
    server.changed(file.path)


gulp.task 'default', ['serve', 'watch']
