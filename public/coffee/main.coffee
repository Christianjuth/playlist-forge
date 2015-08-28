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
        console.log(track)
        $el = $($("#search-result").html()).clone()
        $el.find(".track-id").val(track.id)
        $el.find(".text").text("#{track.name} - #{track.artists[0].name}")
        $("#search-results").append($el)