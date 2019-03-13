$ ->
  if $('.pagination').length && $('#my-posts').length
    $(window).scroll ->
      url = $('.pagination .next_page > a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 70
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />');
        $.getScript(url)
    $(window).scroll()
