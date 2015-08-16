class WFiction.Classes.RemoteForm extends WFiction.Classes.BaseClass
  constructor: (options = {}) ->
    super(options)
    @$from = $(options.el)
    @init()

  init: ->
    @$from.on("change keyup", "input:not(:submit), textarea, select", @handler)
    @$from.on("click", "a.remove_nested_fields, a.add_nested_fields, input[type=\"file\"]", @handler)

  handler: =>