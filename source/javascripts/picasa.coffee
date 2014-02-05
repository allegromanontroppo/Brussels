urls =
  
  userId: '117383595187079962935'

  generate: (url, params = {}, jsonp_placeholder) ->
    
    params['callback'] = jsonp_placeholder 
    
    "#{url}?" + (for param, value of params when value    
      "#{ param }=#{ if param is 'callback' then value else encodeURIComponent(value) }"
    ).join('&') 

  photos: (albumId, jsonp_placeholder, thumbsize = 320, imgmax = 1024) ->

    endpoint = "https://picasaweb.google.com/data/feed/api/user/#{ encodeURIComponent @userId }/albumid/#{ albumId }"
    params = 
      kind: 'photo'
      thumbsize: thumbsize
      imgmax: imgmax
      alt: 'json'

    @generate endpoint, params, jsonp_placeholder

  photo: (albumId, photoId, jsonp_placeholder) ->

    endpoint = "https://picasaweb.google.com/data/feed/api/user/#{ encodeURIComponent @userId }/albumid/#{ albumId }/photoid/#{ photoId }"
    params = 
      imgmax: 'd'
      alt: 'json'

    @generate endpoint, params, jsonp_placeholder
    
window.picasa =    
  
  photos: (album_id, jsonp_placeholder = '?') -> urls.photos(album_id, jsonp_placeholder)
      
  photo: (album_id, photo_id, jsonp_placeholder = '?') -> urls.photo(album_id, photo_id, jsonp_placeholder)

  
    
