ETahi.UploadPreviewComponent = Ember.Component.extend
  file: Ember.computed.alias('upload.file')
  filename: Ember.computed.alias('file.name')

  preview: ( ->
    preview = @get('file.preview')
    preview?.toDataURL()
  ).property('file.preview')

  progress: ( ->
    Math.round(@get('upload.dataLoaded') / @get('upload.dataTotal') * 100)
  ).property('upload.dataLoaded', 'upload.dataTotal')

  error: null

  progressBarStyle: ( ->
    "width: #{@get('progress')}%;"
  ).property('progress')
