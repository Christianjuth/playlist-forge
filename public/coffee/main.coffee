$(document).ready ->
  search_timeout = null
  $("#instant-search").keyup ->
    if search_timeout
      clearTimeout search_timeout
    search_timeout = setTimeout ->
      $("#instant-search").submit()
    , 1000

  $("#instant-search").submit (e)->
    e.preventDefault()
    $.post $(this).attr("action"), $(this).serialize(), (tracks)->
      tracks = jQuery.parseJSON(tracks)
      # data.redirect contains the string URL to redirect to
      $("#search-results").empty()
      for track in tracks
        $("#search-results").append("""
          <form action="/add-to-playlist" method="POST">
            #{$("#instant-search .playlist-id").prop('outerHTML')}
            <input class="hidden" type="text" name="track_id" value="#{track.id}">
            <button class="list-group-item">#{track.name} - #{track.artists[0].name}</button>
          </form>
        """)