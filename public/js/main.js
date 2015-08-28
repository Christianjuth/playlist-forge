(function() {
  $(document).ready(function() {
    var search_timeout;
    search_timeout = null;
    $("#instant-search").keyup(function() {
      if (search_timeout) {
        clearTimeout(search_timeout);
      }
      return search_timeout = setTimeout(function() {
        return $("#instant-search").submit();
      }, 1000);
    });
    return $("#instant-search").submit(function(e) {
      e.preventDefault();
      return $.post($(this).attr("action"), $(this).serialize(), function(tracks) {
        var $el, i, len, results, track;
        tracks = jQuery.parseJSON(tracks);
        $("#search-results").empty();
        results = [];
        for (i = 0, len = tracks.length; i < len; i++) {
          track = tracks[i];
          console.log(track);
          $el = $($("#search-result").html()).clone();
          $el.find(".track-id").val(track.id);
          $el.find(".text").text(track.name + " - " + track.artists[0].name);
          results.push($("#search-results").append($el));
        }
        return results;
      });
    });
  });

}).call(this);
