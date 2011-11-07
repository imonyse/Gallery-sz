# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  albumsModel =
    albums: ko.observableArray([]),
    addAlbum: ->
      this.albums.push({ url: ko.observable(), brief: ko.observable() })
    selectedAlbumURL: ko.observable(),

  window.albumsModel = albumsModel
  ko.applyBindings(albumsModel)
  ko.dependentObservable(->
    @lastAlbumsRequest.abort() if @lastAlbumsRequest
    @lastAlbumsRequest = $.getJSON("/albums", @albums)
  albumsModel)