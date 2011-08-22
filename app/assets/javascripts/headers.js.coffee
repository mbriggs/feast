$ ->
  header = $('img.header')
  window = $(window)

  headerTop = header.offset().top
  breakPoint = headerTop - 40

  above = window.scrollTop > breakPoint

  window.scroll ->
    if window.scrollTop > breakPoint
      header.css(position: 'fixed')
    else
      header.css(position: 'default')
