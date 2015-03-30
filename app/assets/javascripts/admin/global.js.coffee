# Scroll Animation
$.scrollTo = (target, time) ->
  scrollTop = $(target).offset().top - 50
  $('html,body').animate({ scrollTop: scrollTop }, time || 700)