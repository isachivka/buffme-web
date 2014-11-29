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

carusel = (block, in_window, width, left, right, wrap, time, points, napr) ->
  th = 0
  max = $(block).find("ul li").length - in_window
  hover = false
  auto = ->
    to th + 1 unless hover
    setTimeout (->
      auto()
    ), time
  to = (num) ->
    num = max if num < 0
    num = 0 if num > max
    if napr is "top"
      $(block).find(wrap).animate
        'margin-top': num * -1 * width
      , 500, ->
        th = num
    if napr is "left"
      $(block).find(wrap).animate
        "margin-left": num * -1 * width
      , 500, ->
        th = num
    if points
      $(block).find("#{points} a").removeClass("active").addClass("passive")
      $(block).find("#{points} a:eq(#{num})").removeClass("passive").addClass("active")
  setTimeout (->
    auto()
  ), time
  $(block).hover (->
    hover = true
  ), ->
    hover = false
  $(block).find(left).click ->
    to th - 1
    false
  $(block).find(right).click ->
    to th + 1
    false
  if points
    $(block).find("#{points} a").click ->
      n = $(this).prevAll().length
      to n
      false
popups()
carusel '.achievement', 8, 103, 'a.left', 'a.right', 'ul', 300000, '', 'left'
$('input[type="checkbox"]').iCheck()