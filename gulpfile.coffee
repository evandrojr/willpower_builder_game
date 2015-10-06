gulp = require 'gulp'
riot = require 'gulp-riot'

gulp.task 'riot', ->
  gulp.src 'tags/main.tag'
    .pipe riot()
    .pipe gulp.dest 'tags'
