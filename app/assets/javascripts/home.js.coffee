# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  albumsModel =
    albums: ko.observableArray([])
    addAlbum: ->
      @albums.push({ id:(@albums().length + 1).toString(), url: ko.observable(), brief: ko.observable() })
    selectedAlbumId: ko.observable()
    backToIndex: ->
      @selectedAlbumId(null)
      clearTimeout("nextAlbum()")

  albumsModel.selectedAlbum = ko.dependentObservable(->
    albumIdToFind = @selectedAlbumId()
    ko.utils.arrayFirst(albumsModel.albums(), (item) -> item.id == albumIdToFind)
  albumsModel)

  window.albumsModel = albumsModel
  window.selectAlbum = (id) ->
    albumsModel.selectedAlbumId(id)
    setTimeout("nextAlbum()", 5000)

  # looping function, called by setTimeout
  window.nextAlbum = ->
    curAlbumId = albumsModel.selectedAlbumId()
    nextAlbumId = parseInt(curAlbumId) + 1

    if nextAlbumId > albumsModel.albums().length
      nextAlbumId = 1

    selectAlbum(nextAlbumId.toString())

  ko.applyBindings(albumsModel)
  ko.dependentObservable(->
    @lastAlbumsRequest.abort() if @lastAlbumsRequest
    @lastAlbumsRequest = $.getJSON("/albums", @albums)
  albumsModel)