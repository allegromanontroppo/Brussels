(function() {
  var urls;

  urls = {
    userId: '117383595187079962935',
    generate: function(url, params, jsonp_placeholder) {
      var param, value;
      if (params == null) {
        params = {};
      }
      params['callback'] = jsonp_placeholder;
      return ("" + url + "?") + ((function() {
        var _results;
        _results = [];
        for (param in params) {
          value = params[param];
          if (value) {
            _results.push("" + param + "=" + (param === 'callback' ? value : encodeURIComponent(value)));
          }
        }
        return _results;
      })()).join('&');
    },
    photos: function(albumId, jsonp_placeholder, thumbsize, imgmax) {
      var endpoint, params;
      if (thumbsize == null) {
        thumbsize = 320;
      }
      if (imgmax == null) {
        imgmax = 1024;
      }
      endpoint = "https://picasaweb.google.com/data/feed/api/user/" + (encodeURIComponent(this.userId)) + "/albumid/" + albumId;
      params = {
        kind: 'photo',
        thumbsize: thumbsize,
        imgmax: imgmax,
        alt: 'json'
      };
      return this.generate(endpoint, params, jsonp_placeholder);
    },
    photo: function(albumId, photoId, jsonp_placeholder) {
      var endpoint, params;
      endpoint = "https://picasaweb.google.com/data/feed/api/user/" + (encodeURIComponent(this.userId)) + "/albumid/" + albumId + "/photoid/" + photoId;
      params = {
        imgmax: 'd',
        alt: 'json'
      };
      return this.generate(endpoint, params, jsonp_placeholder);
    }
  };

  window.picasa = {
    photos: function(album_id, jsonp_placeholder) {
      if (jsonp_placeholder == null) {
        jsonp_placeholder = '?';
      }
      return urls.photos(album_id, jsonp_placeholder);
    },
    photo: function(album_id, photo_id, jsonp_placeholder) {
      if (jsonp_placeholder == null) {
        jsonp_placeholder = '?';
      }
      return urls.photo(album_id, photo_id, jsonp_placeholder);
    }
  };

}).call(this);
