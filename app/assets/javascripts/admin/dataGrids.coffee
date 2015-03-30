reload_datagrid = (href) ->
  $.ajax href,
    type: 'GET',
    dataType: 'html',
    beforeSend: ->
      NProgress.start()
      $('div.datagrid').fadeTo 500, 0.2
    success: (data) ->
      $('div.datagrid').html data
      $('div.datagrid').fadeTo 500, 1
      NProgress.done()
      $.scrollTo 'div.datagrid'
      init_datagrids()

filter_datagrid = ->
  $.ajax
    type: 'GET',
    dataType: 'html',
    data: $('tr.datagrid-filters input, tr.datagrid-filters textarea, tr.datagrid-filters select').serialize(),
    beforeSend: ->
      NProgress.start()
      $('div.datagrid').fadeTo 500, 0.2
    success: (data) ->
      $('div.datagrid').html data
      $('div.datagrid').fadeTo 500, 1
      NProgress.done()
      $.scrollTo 'div.datagrid'
      init_datagrids()

init_datagrids = ->
  # Pagination via AJAX
  $('div.datagrid ul.pagination a').click ->
    reload_datagrid this.href
    false
  # Ordering via AJAX
  $('div.datagrid-table tr:first th').click ->
    reload_datagrid $(this).find('a').attr('href')
    false
  # Filtering via AJAX
  $('tr.datagrid-filters input, tr.datagrid-filters textarea, tr.datagrid-filters select').change ->
    filter_datagrid()
    false
  # Tooltips
  $('a#tooltip').tooltip()




$(document).ready ->
  init_datagrids()


$(document).on 'page:done', ->
  init_datagrids()