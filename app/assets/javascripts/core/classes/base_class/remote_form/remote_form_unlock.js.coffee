class WFiction.Classes.RemoteFormUnlock extends WFiction.Classes.BaseClass
  constructor: (options = {}) ->
    super(options)

  handler: (event) =>
    @$from.find("#saved-form").hide()
    @$from.find('#not-saved-form').button('reset').show()