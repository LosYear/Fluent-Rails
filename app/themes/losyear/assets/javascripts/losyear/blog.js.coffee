reaload_posts = (url) ->
    $.ajax
      url: url,
      type: 'GET',
      dataType: 'html',
      beforeSend: ->
        NProgress.start()
        $('div.blog-posts').fadeTo 500, 0.2
      success: (data) ->
        $('div.blog-posts').replaceWith data
        NProgress.done()
        $.scrollTo 'div.blog-posts', 1500
        init_blog_pagination()

init_blog_pagination = ->
  $('div.blog-posts ul.pagination a').click ->
    reaload_posts this.href
    false

$(document).on 'page:done', ->
  init_blog_pagination()

$(document).ready ->
  init_blog_pagination()