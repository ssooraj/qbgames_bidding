jQuery ->

  sleep = (ms) ->
    start = new Date().getTime()
    continue while new Date().getTime() - start < ms

  $(window).scroll ->
    url = $('.pagination .next_page').attr('href')
    if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
      $('.pagination').css('visibility', 'visible')
      $('.pagination').text('Loading more...')
      sleep 500
      $.getScript(url)

