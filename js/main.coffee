popups = () ->
  dp = '[data-role="popup"]'
  pops = $(dp)
  pops_open = $('[data-role="popup_open"]')
  pops_close = $('[data-role="popup_close"]')
  wind = '[data-role="popup_window"]'

  $(document).keyup((e) ->
    if e.keyCode == 27 && $(".open#{dp}").length > 0
      close(".open#{dp}")
  )

  open = (pop) ->
    if $(".open#{dp}").length > 0
      close($(".open#{dp}"))
    window.location.hash = pop.replace('#', '')
    $(pop).css('display', 'block')
    $(pop).addClass('open')
    $('body').css('overflow', 'hidden')

  close = (pop) ->
    history.pushState('', document.title, window.location.pathname)
    $(pop).css('display', 'none')
    $(pop).removeClass('open')
    $('body').css('overflow', 'auto')

  $('body').click ->
    if $(".open#{dp}").length > 0
      close(".open#{dp}")

  $(pops).each ->

    id = $(this).attr('id')

    hash = window.location.hash.replace('#', '')
    if hash != '' && hash == id
      open("##{id}")

    $(this).find(wind).click((e) ->
      e.stopPropagation()
    )

  $(pops_open).each ->
    $(this).click ->
      target = $(this).attr('data-target')
      if $(target).length > 0
        open(target)
      false

  $(pops_close).each ->
    $(this).click ->
      target = $(this).parents(dp)
      if $(target).length > 0
        close(target)
      false

popups()