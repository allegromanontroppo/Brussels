//= require picasa
//= require masonry.pkgd.min
//= require imagesloaded.pkgd.min

album_id = '5976637713795292929'
album_url = picasa.photos(album_id, 'JSON_CALLBACK')

app = angular.module('brusselsApp', [])
app.controller('brusselsCtrl', ($scope, $http) ->
  $scope.photos = []
  
  $http.jsonp(album_url).success (response) ->
    $scope.photos = response?.feed?.entry
)

app.directive('masonry', ->
  {
    restrict: 'A'
    link: (scope, elem, attrs) ->

      container = elem[0]
      options = 
        itemSelector: '.masonry-tile'
        columnWidth: 0
      options = angular.extend(options, JSON.parse(attrs.mhMasonry)) if attrs.mhMasonry

      elem.ready -> 
        imagesLoaded container, ->
          new Masonry(container, options)
  }
)

app.directive('lightbox', ->
  {
    restrict: 'A'
    link: (scope, elem, attrs) ->

      elem.ready -> 
        $(elem[0]).magnificPopup
          delegate: "a"
          type: "image"
          tLoading: "Loading image #%curr%..."
          mainClass: "mfp-img-mobile"
          gallery:
            enabled: true
            navigateByImgClick: true
            preload: [0,1]

          image:
            tError: "<a href=\"%url%\">The image #%curr%</a> could not be loaded."
            titleSrc: (item) ->
              item.el.attr("title")
        
  }
)

