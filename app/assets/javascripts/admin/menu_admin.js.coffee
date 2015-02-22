init = ->
  $('span.order-up').click ->
    el = $(this).closest 'li'
    el.prev('li').before(el)

  $('span.order-down').click ->
    el = $(this).closest 'li'
    el.next('li').after(el)

  $('button#save-order').click ->
    data = {}
    order = 0

    # Creating array with orders
    $('ul.menu-admin li').each ->
      id = $(this).data('id')
      data[id] = order
      order++

    # Making an AJAX call
    $.ajax order_url,
      type: 'POST'
      dataType: 'text'
      data:
        data: data
      success: (response) ->
        alert response



$(document).ready ->
  init()
  jQuery('select[readonly] option:not(:selected)').attr('disabled', true)
#$('.glyphicon-arrow-up').click(function(){ var div = $(this).closest('.li'); div.prev('li').before(div);});
#$div.next('.item').after($div);