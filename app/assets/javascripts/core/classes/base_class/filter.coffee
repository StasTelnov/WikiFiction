class WFiction.Classes.Filter extends WFiction.Classes.BaseClass

  constructor: (options = {}) ->
    super(options)
    @$el = $(options.el)

    @$el.on 'change', (event) =>
      $.ajax
        url: '/line_items/' + @$el.attr('id') + '?' + $.param(line_item: quantity: @$el.val())
        type: 'put'
        dataType: 'script'

#    $('.item-quantity').on 'change', (event) ->
#      el = $(event.currentTarget)
#      value = parseInt(el.val())
#      $.ajax
#        url: /line_items/ + $(el).attr('id') + '?' + $.param(line_item: quantity: value)
#        type: 'put'
#        dataType: 'script'